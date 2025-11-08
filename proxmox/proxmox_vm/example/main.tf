terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.60"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = var.proxmox_insecure

  ssh {
    agent       = false
    username    = var.proxmox_ssh_username
    private_key = file(pathexpand(var.proxmox_ssh_private_key))
  }
}

module "test_vm" {
  source = "../"

  instances_count = var.instances_count
  hostname        = var.hostname
  node_name       = var.node_name

  vCPU     = var.vcpu
  vMEM     = var.vmem
  disksize = var.disksize

  datastore_id          = var.datastore_id
  snippets_datastore_id = var.snippets_datastore_id
  network_bridge        = var.network_bridge
  template              = var.template
  iso_file              = var.iso_file

  distro               = var.distro
  enable_vendor_config = var.enable_vendor_config

  domain           = var.domain
  ip_addresses     = var.ip_addresses
  gateway          = var.gateway
  dns_servers      = var.dns_servers

  ssh_public_keyfile = var.ssh_public_keyfile

  tags = var.tags
}