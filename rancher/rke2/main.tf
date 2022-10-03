resource "random_pet" "pet" {
  length = 3
}
locals {
  kubeconfig_path   = pathexpand(var.kubeconfig_path)
  vipip             = var.vip_address
  deploy_kubevip    = var.kube_vip
  fqdn              = var.vip_fqdn
  servernode_amount = length(var.servernodes)
  agentnode_amount  = length(var.agentnodes)
  servernodes       = var.servernodes
  agentnodes        = var.agentnodes
  ssh_user_agent    = var.ssh_user_agent
  ssh_key_agent     = file(pathexpand(var.ssh_key_agent))
  ssh_user_server   = var.ssh_user_server
  ssh_key_server    = file(pathexpand(var.ssh_key_server))
  network_interface = var.network_interface
  token             = random_pet.pet.id
}