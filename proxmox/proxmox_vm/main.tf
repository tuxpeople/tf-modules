locals {
  user_data = var.user_data != "" ? var.user_data : "${path.module}/files/cloud-init-userdata.tftpl"

  network_device_base = {
    bridge = var.network_bridge
  }

  network_device_mac = length(var.mac_address) > 0 && var.mac_address[0] != "" ? { mac_address = var.mac_address[0] } : {}

  network_device_final = merge(local.network_device_base, local.network_device_mac)

  use_external_user_data   = length(var.external_user_data_file_ids) >= var.instances_count && length(compact(slice(var.external_user_data_file_ids, 0, min(var.instances_count, length(var.external_user_data_file_ids))))) == var.instances_count
  use_external_meta_data   = length(var.external_meta_data_file_ids) >= var.instances_count && length(compact(slice(var.external_meta_data_file_ids, 0, min(var.instances_count, length(var.external_meta_data_file_ids))))) == var.instances_count
  use_external_vendor_data = length(var.external_vendor_data_file_ids) >= var.instances_count && length(compact(slice(var.external_vendor_data_file_ids, 0, min(var.instances_count, length(var.external_vendor_data_file_ids))))) == var.instances_count

  create_user_data_files   = !local.use_external_user_data
  create_meta_data_files   = !local.use_external_meta_data
  create_vendor_data_files = var.enable_vendor_config && !local.use_external_vendor_data

  default_disk = {
    datastore_id = var.datastore_id
    file_id      = var.template != "" ? var.template : null
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.disksize
  }

  disk_definitions = length(var.disks) > 0 ? var.disks : [local.default_disk]

  cloud_init_wait_defaults = {
    enabled         = false
    script_path     = ""
    ssh_user        = ""
    ssh_private_key = ""
    reboot_delay    = 30
    timeout         = 900
  }

  cloud_init_wait_config  = var.cloud_init_wait != null ? var.cloud_init_wait : local.cloud_init_wait_defaults
  cloud_init_wait_script  = trimspace(local.cloud_init_wait_config.script_path) != "" ? (startswith(local.cloud_init_wait_config.script_path, "/") ? local.cloud_init_wait_config.script_path : abspath(local.cloud_init_wait_config.script_path)) : ""
  cloud_init_wait_enabled = local.cloud_init_wait_config.enabled && local.cloud_init_wait_script != ""

  # Distro-specific vendor configurations
  vendor_configs = {
    "ubuntu" = <<-EOF
    #cloud-config
    runcmd:
      - apt update
      - apt install -y qemu-guest-agent
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "Ubuntu vendor config completed" > /tmp/vendor-config-done
    EOF

    "rocky" = <<-EOF
    #cloud-config
    runcmd:
      - dnf update -y
      - dnf install -y qemu-guest-agent
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "Rocky Linux vendor config completed" > /tmp/vendor-config-done
    EOF

    "debian" = <<-EOF
    #cloud-config
    runcmd:
      - apt update
      - apt install -y qemu-guest-agent
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "Debian vendor config completed" > /tmp/vendor-config-done
    EOF

    "centos" = <<-EOF
    #cloud-config
    runcmd:
      - yum update -y
      - yum install -y qemu-guest-agent
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "CentOS vendor config completed" > /tmp/vendor-config-done
    EOF

    "fedora" = <<-EOF
    #cloud-config
    runcmd:
      - dnf update -y
      - dnf install -y qemu-guest-agent
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "Fedora vendor config completed" > /tmp/vendor-config-done
    EOF
  }
}

resource "proxmox_virtual_environment_file" "vendor_config" {
  count = local.create_vendor_data_files ? var.instances_count : 0

  content_type = "snippets"
  datastore_id = var.snippets_datastore_id
  node_name    = var.node_name

  source_raw {
    data      = local.vendor_configs[var.distro]
    file_name = "${var.instances_count == 1 ? var.hostname : format("${var.hostname}%02s", count.index + 1)}-vendor-config.yaml"
  }
}

resource "proxmox_virtual_environment_file" "main" {
  count = local.create_meta_data_files ? var.instances_count : 0

  content_type = "snippets"
  datastore_id = var.snippets_datastore_id
  node_name    = var.node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    local-hostname: ${var.instances_count == 1 ? var.hostname : format("${var.hostname}%02s", count.index + 1)}
    EOF

    file_name = "meta-data-${var.instances_count == 1 ? var.hostname : format("${var.hostname}%02s", count.index + 1)}.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "main" {
  count = var.instances_count

  name        = var.instances_count == 1 ? var.hostname : format("${var.hostname}%02s", count.index + 1)
  description = "Managed by Terraform"
  node_name   = var.node_name
  pool_id     = var.pool_id

  stop_on_destroy = var.stop_on_destroy

  agent {
    enabled = var.agent_enabled
  }

  startup {
    order      = var.startup_order
    up_delay   = var.startup_up_delay
    down_delay = var.startup_down_delay
  }

  cpu {
    cores = var.vCPU
    type  = var.cpu_type
  }

  memory {
    dedicated = var.vMEM
    floating  = var.vMEM
  }

  dynamic "disk" {
    for_each = local.disk_definitions
    content {
      datastore_id = disk.value.datastore_id
      file_id      = disk.value.file_id
      interface    = disk.value.interface
      iothread     = disk.value.iothread
      discard      = disk.value.discard
      size         = disk.value.size
    }
  }

  dynamic "cdrom" {
    for_each = var.iso_file != "" ? [1] : []
    content {
      enabled   = true
      file_id   = var.iso_file
      interface = "ide0"
    }
  }

  network_device {
    bridge      = local.network_device_final.bridge
    mac_address = try(local.network_device_final.mac_address, null)
    vlan_id     = length(var.vlan_ids) > count.index ? var.vlan_ids[count.index] : null
  }

  operating_system {
    type = var.os_type
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ip_addresses[count.index] != "" ? var.ip_addresses[count.index] : "dhcp"
        gateway = var.gateway != "" ? var.gateway : null
      }
    }

    user_data_file_id   = local.user_data_file_ids[count.index]
    meta_data_file_id   = local.meta_data_file_ids[count.index]
    vendor_data_file_id = var.enable_vendor_config ? (length(local.vendor_data_file_ids) > 0 ? local.vendor_data_file_ids[count.index] : null) : null

    dynamic "dns" {
      for_each = var.domain != "" || length(var.dns_servers) > 0 ? [1] : []
      content {
        domain  = var.domain != "" ? var.domain : null
        servers = length(var.dns_servers) > 0 ? var.dns_servers : null
      }
    }
  }

  tags = var.tags


  lifecycle {
    ignore_changes = [
      initialization[0].user_data_file_id,
      initialization[0].meta_data_file_id,
      initialization[0].vendor_data_file_id,
    ]
  }
}

resource "null_resource" "cloudinit_wait" {
  count = local.cloud_init_wait_enabled ? var.instances_count : 0

  triggers = {
    vm_id = proxmox_virtual_environment_vm.main[count.index].id
    host = can(proxmox_virtual_environment_vm.main[count.index].ipv4_addresses[1][0]) ? split("/", proxmox_virtual_environment_vm.main[count.index].ipv4_addresses[1][0])[0] : (
      can(proxmox_virtual_environment_vm.main[count.index].ipv4_addresses[0][0]) ? split("/", proxmox_virtual_environment_vm.main[count.index].ipv4_addresses[0][0])[0] : ""
    )
  }

  provisioner "local-exec" {
    command = format(
      "%s %q %q %q %d %d",
      local.cloud_init_wait_script,
      self.triggers.host,
      local.cloud_init_wait_config.ssh_user,
      local.cloud_init_wait_config.ssh_private_key,
      local.cloud_init_wait_config.reboot_delay,
      local.cloud_init_wait_config.timeout,
    )
  }

  depends_on = [proxmox_virtual_environment_vm.main]
}


resource "proxmox_virtual_environment_file" "cloud_config" {
  count = local.create_user_data_files ? var.instances_count : 0

  content_type = "snippets"
  datastore_id = var.snippets_datastore_id
  node_name    = var.node_name

  source_raw {
    data = templatefile(local.user_data, {
      pubkey      = file(pathexpand(var.ssh_public_keyfile))
      hostname    = var.instances_count == 1 ? var.hostname : format("${var.hostname}%02s", count.index + 1)
      fqdn        = var.instances_count == 1 ? "${var.hostname}.${var.domain}" : format("${var.hostname}%02s.${var.domain}", count.index + 1)
      instance_id = var.instances_count == 1 ? var.hostname : format("${var.hostname}%02s", count.index + 1)
    })
    file_name = "${var.instances_count == 1 ? var.hostname : format("${var.hostname}%02s", count.index + 1)}-cloud-init.yaml"
  }
}
