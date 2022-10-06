resource "ssh_resource" "rke2_agent_config_dir" {
  count = local.agentnode_amount
    host        = local.agentnodes[count.index]
    user        = local.ssh_user_agent
    private_key = local.ssh_key_agent
  commands = [
    "sudo mkdir -p /etc/rancher/rke2",
    "sudo chmod 777 /etc/rancher/rke2"
  ]
}

data "template_file" "rke2_agent_config" {
  count = local.agentnode_amount
  template = file("${path.module}/files/rke2-conf.tftpl")
  vars = {
      MACHINENO = count.index + 1
      NODETYPE  = "worker"
      TOKEN     = random_password.cluster-token
      VIP       = local.vipip
      FQDN      = local.fqdn
  }
}

resource "ssh_resource" "rke2_agent_config" {
  depends_on = [
    ssh_resource.rke2_agent_config_dir,
    data.template_file.rke2_agent_config
  ]

  count = local.agentnode_amount

  triggers = {
    template = data.template_file.rke2_agent_config[count.index]
  }

  file {
    content     = data.template_file.rke2_agent_config[count.index]
    destination = "/etc/rancher/rke2/config.yaml"
    permissions = "0644"
  }

  user        = local.ssh_user_agent
  private_key = local.ssh_key_agent
  host        = local.agentnodes.0
}

resource "ssh_resource" "install-agent-nodes" {
  depends_on = [ssh_resource.deploy-first-servernode]

  count      = local.agentnode_amount

  triggers = {
    config = replace(replace(jsonencode(ssh_resource.rke2_agent_config.*.id), "\"", ""), ":", "=")
  }

  commands = [
    "while ! timeout 1 bash -c \"cat < /dev/null > /dev/tcp/${local.fqdn}/9345\"; do echo \"Waiting for Kubernetes API to become ready\"; sleep 5; done",
    # TODO INSTALL_RKE2_VERSION=${var.rke2_version}
    "curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_TYPE=\"agent\" sh -",
    "sudo systemctl enable rke2-agent.service",
    "sudo systemctl start rke2-agent.service",
  ]

  user        = local.ssh_user_agent
  private_key = local.ssh_key_agent
  host        = local.agentnodes[count.index]
}