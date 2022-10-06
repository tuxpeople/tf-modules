resource "null_resource" "deploy-rke2-server-config" {
  count = local.servernode_amount
  triggers = {
    template = templatefile("${path.module}/files/rke2-conf.tftpl", {
      MACHINENO = count.index
      NODETYPE  = local.agentnode_amount >= "1" ? "masteronly" : "allinone"
      TOKEN     = local.token
      VIP       = local.vipip
    FQDN = local.fqdn })
  }

  provisioner "file" {
    content     = self.triggers.template
    destination = "/tmp/config.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /etc/rancher/rke2",
      "sudo cp /tmp/config.yaml /etc/rancher/rke2/",
    ]
  }

  connection {
    type        = "ssh"
    user        = local.ssh_user_server
    private_key = local.ssh_key_server
    host        = local.servernodes[count.index]
  }
}

resource "null_resource" "deploy-kubevip" {
  count = local.deploy_kubevip == true ? 1 : 0
  triggers = {
    template = templatefile("${path.module}/files/deploy-kubevip.tftpl", { INTERFACE = local.network_interface, VIP = local.vipip })
  }
  provisioner "file" {
    content     = self.triggers.template
    destination = "/tmp/deploy-kubevip.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/deploy-kubevip.sh",
      "sudo /tmp/deploy-kubevip.sh",
    ]
  }
  connection {
    type        = "ssh"
    user        = local.ssh_user_server
    private_key = local.ssh_key_server
    host        = local.servernodes.0
  }
}

resource "ssh_resource" "deploy-first-servernode" {
  depends_on = [null_resource.deploy-rke2-server-config]
  triggers = {
    config = null_resource.deploy-rke2-server-config.id
  }
  commands = [
    "if command -v rke2-uninstall.sh &> /dev/null; then /usr/bin/rke2-uninstall.sh; sleep 30; fi",
    "curl -sfL https://get.rke2.io | sudo sh -",
    "sleep 10",
    "sudo systemctl enable rke2-server.service",
    "sudo systemctl start rke2-server.service",
    "sleep 10",
    "sudo /var/lib/rancher/rke2/bin/kubectl --insecure-skip-tls-verify --kubeconfig /etc/rancher/rke2/rke2.yaml wait --for=condition=Ready nodes --all --timeout=600s"
  ]
  user        = local.ssh_user_server
  private_key = local.ssh_key_server
  host        = local.servernodes.0
}
resource "null_resource" "set_initial_state" {
  depends_on = [ssh_resource.deploy-first-servernode]
  triggers = {
    config = null_resource.deploy-rke2-server-config.id
  }
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "echo \"0\" > initial_state.txt"
  }
}
resource "ssh_resource" "other-servernodes" {
  depends_on = [null_resource.set_initial_state]
  count      = local.servernode_amount - 1
  triggers = {
    config = null_resource.deploy-rke2-server-config.id
  }

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "while [[ $(cat initial_state.txt) != \"${count.index}\" ]]; do echo \"${count.index} is asleep...\";((c++)) && ((c==180)) && break;sleep 15;done"
  }

  commands = [
    "while ! timeout 1 bash -c \"cat < /dev/null > /dev/tcp/${local.fqdn}/9345\"; do echo \"Waiting for Kubernetes API to become ready\"; sleep 5; done",
    "if command -v rke2-uninstall.sh &> /dev/null; then /usr/bin/rke2-uninstall.sh; sleep 30; fi",
    "curl -sfL https://get.rke2.io | sudo sh -",
    "sudo systemctl enable rke2-server.service",
    "sudo systemctl start rke2-server.service",
    "sleep 10",
    "sudo /var/lib/rancher/rke2/bin/kubectl --insecure-skip-tls-verify --kubeconfig /etc/rancher/rke2/rke2.yaml wait --for=condition=Ready nodes --all --timeout=600s"
  ]
  user        = local.ssh_user_server
  private_key = local.ssh_key_server
  host        = local.servernodes[count.index + 1]

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "echo \"${count.index + 1}\" > initial_state.txt"
  }
}

resource "ssh_resource" "retrieve_config_management" {
  depends_on = [
    ssh_resource.deploy-first-servernode
  ]
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