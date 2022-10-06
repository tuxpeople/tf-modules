resource "null_resource" "deploy-rke2-worker-config" {
  count = local.agentnode_amount
  triggers = {
    template = templatefile("${path.module}/files/rke2-conf.tftpl", {
      MACHINENO = count.index + 1
      NODETYPE  = "worker"
      TOKEN     = local.token
      VIP       = local.vipip
      FQDN      = local.fqdn
    })
  }
  provisioner "file" {
    content     = self.triggers.template
    destination = "/tmp/config.yaml"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /etc/rancher/rke2",
      "sudo mv /tmp/config.yaml /etc/rancher/rke2/",
    ]
  }
  connection {
    type        = "ssh"
    user        = local.ssh_user_agent
    private_key = local.ssh_key_agent
    host        = local.agentnodes[count.index]
  }
}

resource "ssh_resource" "install-agent-nodes" {
  depends_on = [ssh_resource.deploy-first-servernode]
  count      = local.agentnode_amount
  triggers = {
    replace(replace(jsonencode(null_resource.deploy-rke2-worker-config.*.id), "\"", ""), ":", "=")
  }
  commands = [
    "while ! timeout 1 bash -c \"cat < /dev/null > /dev/tcp/${local.fqdn}/9345\"; do echo \"Waiting for Kubernetes API to become ready\"; sleep 5; done",
    "if command -v rke2-uninstall.sh &> /dev/null; then /usr/bin/rke2-uninstall.sh; sleep 30; fi",
    "curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_TYPE=\"agent\" sh -",
    "sudo systemctl enable rke2-agent.service",
    "sudo systemctl start rke2-agent.service",
  ]
  user        = local.ssh_user_agent
  private_key = local.ssh_key_agent
  host        = local.agentnodes[count.index]
}