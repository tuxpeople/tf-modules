resource "ssh_resource" "rke2_server_config_dir" {
  count       = local.servernode_amount
  host        = local.servernodes[count.index]
  user        = local.ssh_user_server
  private_key = local.ssh_key_server
  commands = [
    "sudo mkdir -p /etc/rancher/rke2",
    "sudo chmod 777 /etc/rancher/rke2"
  ]
}

data "template_file" "rke2_server_config" {
  count    = local.servernode_amount
  template = file("${path.module}/files/rke2-conf.tftpl")
  vars = {
    MACHINENO = count.index
    NODETYPE  = local.agentnode_amount >= "1" ? "masteronly" : "allinone"
    TOKEN     = random_password.cluster-token.result
    VIP       = local.vipip
    FQDN      = local.fqdn
  }
}

data "template_file" "kubevip_config" {
  count    = local.deploy_kubevip == true ? 1 : 0
  template = file("${path.module}/files/deploy-kubevip.tftpl")
  vars = {
    INTERFACE = local.network_interface
    VIP       = local.vipip
    VERSION   = kubevip_available_versions[0]
  }
}

resource "ssh_resource" "rke2_server_config" {
  depends_on = [
    ssh_resource.rke2_server_config_dir,
    data.template_file.rke2_server_config
  ]

  count = local.servernode_amount

  triggers = {
    template = data.template_file.rke2_server_config[count.index].rendered
  }

  file {
    content     = data.template_file.rke2_server_config[count.index].rendered
    destination = "/etc/rancher/rke2/config.yaml"
    permissions = "0644"
  }

  user        = local.ssh_user_server
  private_key = local.ssh_key_server
  host        = local.servernodes.0
}

resource "ssh_resource" "deploy-kubevip" {
  count = local.deploy_kubevip == true ? 1 : 0

  triggers = {
    template = data.template_file.kubevip_config[count.index].rendered
  }

  file {
    content     = data.template_file.kubevip_config[count.index].rendered
    destination = "/tmp/deploy-kubevip.sh"
    permissions = "0644"
  }

  commands = [
    "chmod +x /tmp/deploy-kubevip.sh",
    "sudo /tmp/deploy-kubevip.sh"
  ]

  user        = local.ssh_user_server
  private_key = local.ssh_key_server
  host        = local.servernodes.0
}

resource "ssh_resource" "deploy-first-servernode" {
  depends_on = [ssh_resource.rke2_server_config]

  triggers = {
    config = replace(replace(jsonencode(ssh_resource.rke2_server_config.*.id), "\"", ""), ":", "=")
  }

  commands = [
    "sleep 1m",
    "curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=\"${local.rke2_version}\" sh -",
    "sudo systemctl enable rke2-server.service",
    "sudo systemctl start rke2-server.service",
    "sleep 10",
    "sudo /var/lib/rancher/rke2/bin/kubectl --insecure-skip-tls-verify --kubeconfig /etc/rancher/rke2/rke2.yaml wait --for=condition=Ready nodes --all --timeout=600s"
  ]

  user        = local.ssh_user_server
  private_key = local.ssh_key_server
  host        = local.servernodes.0
}

resource "ssh_resource" "deploy-other-servernodes" {
  depends_on = [ssh_resource.deploy-first-servernode, ssh_resource.rke2_server_config]

  count = local.servernode_amount - 1

  triggers = {
    config = replace(replace(jsonencode(ssh_resource.rke2_server_config.*.id), "\"", ""), ":", "=")
  }

  commands = [
    "while ! timeout 1 bash -c \"cat < /dev/null > /dev/tcp/${local.fqdn}/9345\"; do echo \"Waiting for Kubernetes API to become ready\"; sleep 5; done",
    "curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_VERSION=\"${local.rke2_version}\" sh -",
    "sleep ${count.index}m",
    "sudo systemctl enable rke2-server.service",
    "sudo systemctl start rke2-server.service",
    "sleep 10",
    "sudo /var/lib/rancher/rke2/bin/kubectl --insecure-skip-tls-verify --kubeconfig /etc/rancher/rke2/rke2.yaml wait --for=condition=Ready nodes --all --timeout=600s"
  ]
  user        = local.ssh_user_server
  private_key = local.ssh_key_server
  host        = local.servernodes[count.index + 1]
}

resource "ssh_resource" "retrieve_config_management" {
  depends_on = [ssh_resource.deploy-first-servernode]

  triggers = {
    config = replace(replace(jsonencode(ssh_resource.rke2_server_config.*.id), "\"", ""), ":", "=")
  }

  host = local.servernodes.0

  commands = [
    "sleep 60 && sudo sed \"s/127.0.0.1/${local.fqdn}/g\" /etc/rancher/rke2/rke2.yaml"
  ]

  user        = local.ssh_user_server
  private_key = local.ssh_key_server
}

resource "local_file" "kubeconfig" {
  filename = local.kubeconfig_path
  content  = ssh_resource.retrieve_config_management.result
}