locals {
  user_data = var.user_data != "" ? var.user_data : "${path.module}/files/cloud-init-userdata.tftpl"
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

  name     = (var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")
  num_cpus = var.vCPU
  memory   = var.vMEM
  guest_id = data.vsphere_virtual_machine.template[count.index].guest_id

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

  /* vapp {
    properties = {
      user-data = base64encode(templatefile(local.user_data, ({
        pubkey      = file(pathexpand(var.ssh_public_keyfile))
        hostname    = (var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")
        instance_id = (var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")
      })))
      hostname    = "${var.hostname}"
      instance-id = "${var.hostname}"
    }
  } */

  extra_config = {
    "guestinfo.metadata" = base64encode(templatefile("${path.module}/files/cloud-init-metadata.tftpl", ({
      fqdn        = (var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")
      hostname    = (var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")
      instance_id = (var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")
    })))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata" = base64encode(templatefile(local.user_data, ({
      pubkey          = file(pathexpand(var.ssh_public_keyfile))
      guest_id        = var.guest_id
      redhat_username = var.redhat_username
      redhat_password = var.redhat_password
      fqdn            = (var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")
      hostname        = (var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")
      instance_id     = (var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")
    })))
    "guestinfo.userdata.encoding" = "base64"
  }

  wait_for_guest_net_routable = var.wait_for_guest_net_routable
  wait_for_guest_net_timeout  = var.wait_for_guest_net_timeout

connection {  
    type        = "ssh"  
    user        = "ansible"  
    host        = self.default_ip_address  
    timeout     = "10m"  
}  
provisioner "remote-exec" {  
    inline = [  
    "echo 'Waiting for user data script to finish'",  
    "cloud-init status --wait > /dev/null"  
    ]  
}

  /* provisioner "local-exec" {
    command = "while ! nc -z ${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")} 22; do sleep 10; done; ssh -o StrictHostKeyChecking=no ansible@${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")} 'cloud-init status --wait > /dev/null'; sleep 20"
  } */

  provisioner "local-exec" {
    command = "while ! nc -z ${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")} 22; do sleep 20; done; ssh-keygen -R $(dig +short ${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")}); ssh-keygen -R ${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")}; ssh-keyscan -t rsa $(dig +short ${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")}),${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")} >> ~/.ssh/known_hosts; ssh ansible@${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")} 'cloud-init status --wait > /dev/null'; sleep 20"
  }
}

/* resource "null_resource" "cleanup_ssh_keys" {
  for_each = setunion(vsphere_virtual_machine.main.*.default_ip_address, vsphere_virtual_machine.main.*.name)
  provisioner "local-exec" {
    command = "ssh-keygen -R ${each.key}; ssh-keygen -R ${each.blubb}; ssh-keyscan -t rsa ${each.key},${each.blubb} >> ~/.ssh/known_hosts"vcenter.lab.tdeutsch.ch
    #command = "ssh-keygen -R ${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")}; ssh-keygen -R ${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")}.${var.domain}; ssh-keygen -R $(dig +short ${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")}); ssh-keyscan -t rsa ${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")},$(dig +short ${(var.instances_count == "1" ? "${var.hostname}" : "${format("${var.hostname}%02s", (count.index + 1))}")}) >> ~/.ssh/known_hosts"
  }
} */

