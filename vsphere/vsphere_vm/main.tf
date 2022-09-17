locals {
  user_data  = var.user_data != "" ? var.user_data : "${path.module}/files/cloud-init-userdata.tftpl"
  clean_name = substr(lower(replace(var.hostname, "/[[:^alnum:]]/", "")), 0, 60)
}

data "vsphere_datacenter" "main" {
  count = var.instances_count
  name  = var.datacenter
}

data "vsphere_compute_cluster" "main" {
  count         = var.instances_count
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.main[count.index].id
}

data "vsphere_datastore" "main" {
  count         = var.instances_count
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.main[count.index].id
}

data "vsphere_network" "main" {
  count         = var.instances_count
  name          = var.network
  datacenter_id = data.vsphere_datacenter.main[count.index].id
}

data "vsphere_virtual_machine" "template" {
  count         = var.instances_count
  name          = var.template
  datacenter_id = data.vsphere_datacenter.main[count.index].id
}

resource "vsphere_virtual_machine" "main" {
  count = var.instances_count

  resource_pool_id = data.vsphere_compute_cluster.main[count.index].resource_pool_id
  datastore_id     = data.vsphere_datastore.main[count.index].id
  folder           = var.folder

  name                       = (var.instances_count == "1" ? "${local.clean_name}" : "${local.clean_name}${(count.index + 1)}")
  num_cpus                   = var.vCPU
  memory                     = var.vMEM
  guest_id                   = data.vsphere_virtual_machine.template[count.index].guest_id
  wait_for_guest_net_timeout = 0

  cdrom {
    client_device = true
  }

  network_interface {
    network_id = data.vsphere_network.main[count.index].id
  }

  disk {
    label            = "disk0"
    size             = var.disksize
    eagerly_scrub    = var.eagerly_scrub
    thin_provisioned = var.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template[count.index].id
  }

  vapp {
    properties = {
      user-data = base64encode(templatefile(local.user_data, ({
        pubkey      = file(pathexpand(var.ssh_public_keyfile))
        hostname    = (var.instances_count == "1" ? "${local.clean_name}" : "${local.clean_name}${(count.index + 1)}")
        instance_id = (var.instances_count == "1" ? "${local.clean_name}" : "${local.clean_name}${(count.index + 1)}")
      })))
      hostname    = "${local.clean_name}"
      instance-id = "${local.clean_name}"
    }
  }

  extra_config = {
    "guestinfo.metadata"          = base64encode(templatefile("${path.module}/files/cloud-init-metadata.tftpl", ({
        hostname    = (var.instances_count == "1" ? "${local.clean_name}" : "${local.clean_name}${(count.index + 1)}")
        instance_id = (var.instances_count == "1" ? "${local.clean_name}" : "${local.clean_name}${(count.index + 1)}")
      })))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(templatefile(local.user_data, ({
        pubkey      = file(pathexpand(var.ssh_public_keyfile))
      })))
    "guestinfo.userdata.encoding" = "base64"
  }

  provisioner "local-exec" {
    command = "fix-ssh-key ${local.clean_name}"
  }
}
