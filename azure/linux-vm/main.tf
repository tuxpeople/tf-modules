resource "random_string" "unique_suffix" {
  upper   = false
  special = false
  length  = 5
}

locals {
  clean_name = substr(lower(replace(var.name, "/[[:^alnum:]]/", "")), 0, 60)

  host_name   = var.dns_name != "" ? lower(replace(var.dns_name, "/[[:^alnum:]]/", "")) : local.clean_name
  host_domain = var.dns_domain != "" ? lower(var.dns_domain) : "${random_string.unique_suffix.result}.${var.location}.cloudapp.azure.com"
  nsg_inbound_rules = { for idx, security_rule in var.nsg_inbound_rules : security_rule.name => {
    idx : idx,
    security_rule : security_rule,
    }
  }

  default_tags = var.default_tags_enabled ? {
    environment = var.environment
  } : {}
}

resource "azurerm_linux_virtual_machine" "main" {
  count                 = var.instances_count
  name                  = var.instances_count != "1" ? "vm-${local.host_name}" : "vm-${local.host_name}${(count.index + 1)}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = var.vmsize_list[lower(var.vmsize_name)]["size"]
  admin_username        = var.vm_username
  network_interface_ids = [element(concat(azurerm_network_interface.main.*.id, [""]), count.index)]
  custom_data = var.custom_data != "" ? base64encode(var.custom_data) : (var.cloud_init_file != "" ? base64encode(templatefile(var.cloud_init_file, var.custom_data_vars != "" ? var.custom_data_vars : ({
    FQDN     = (var.instances_count != "1" ? "${local.host_name}-${local.host_domain}" : "${local.host_name}${(count.index + 1)}-${local.host_domain}"),
    HOSTNAME = (var.instances_count != "1" ? "vm-${local.host_name}" : "vm-${local.host_name}${(count.index + 1)}")
  }))) : null)

  admin_ssh_key {
    username   = var.vm_username
    public_key = file(var.ssh_public_keyfile)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.linux_distribution_list[lower(var.linux_distribution_name)]["publisher"]
    offer     = var.linux_distribution_list[lower(var.linux_distribution_name)]["offer"]
    sku       = var.linux_distribution_list[lower(var.linux_distribution_name)]["sku"]
    version   = var.linux_distribution_list[lower(var.linux_distribution_name)]["version"]
  }

  tags = merge(local.default_tags, var.extra_tags, var.enable_public_ip_address == true ? { FQDN = "${local.host_name}${(count.index + 1)}-${local.host_domain}" } : null)

  lifecycle {
    ignore_changes = [
      tags,
      identity,
    ]
  }
}

resource "azurerm_network_interface" "main" {
  count               = var.instances_count
  name                = var.instances_count != "1" ? "vm-${local.host_name}_nic" : "vm-${local.host_name}${(count.index + 1)}_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip_address == true ? element(concat(azurerm_public_ip.main.*.id, [""]), count.index) : null
  }
  tags = merge(local.default_tags, var.extra_tags)
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_public_ip" "main" {
  count               = var.enable_public_ip_address == true ? var.instances_count : 0
  name                = var.instances_count != "1" ? "vm-${local.host_name}_pip" : "vm-${local.host_name}${(count.index + 1)}_pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = var.instances_count != "1" ? "${local.host_name}-${random_string.unique_suffix.result}" : "${local.host_name}${(count.index + 1)}-${random_string.unique_suffix.result}"
  reverse_fqdn        = var.instances_count != "1" ? "${local.host_name}-${local.host_domain}" : "${local.host_name}${(count.index + 1)}-${local.host_domain}"

  tags = merge(local.default_tags, var.extra_tags)
  lifecycle {
    ignore_changes = [
      tags,
      ip_tags,
    ]
  }
}

resource "azurerm_network_security_group" "main" {
  name                = "vm-${local.clean_name}_nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(local.default_tags, var.extra_tags)
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_network_security_rule" "nsg_rule" {
  for_each                    = { for k, v in local.nsg_inbound_rules : k => v if k != null }
  name                        = each.key
  priority                    = 100 * (each.value.idx + 1)
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value.security_rule.destination_port_range
  source_address_prefix       = each.value.security_rule.source_address_prefix
  destination_address_prefix  = "*"
  description                 = "Inbound_Port_${each.value.security_rule.destination_port_range}"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.main.name
  depends_on                  = [azurerm_network_security_group.main]
}


resource "azurerm_network_interface_security_group_association" "main" {
  count                     = var.instances_count
  network_interface_id      = element(concat(azurerm_network_interface.main.*.id, [""]), count.index)
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "main" {
  count              = var.instances_count
  virtual_machine_id = element(concat(azurerm_linux_virtual_machine.main.*.id, [""]), count.index)
  location           = var.location
  enabled            = var.enable_vm_shutdown

  daily_recurrence_time = var.shutdown_time
  timezone              = var.timezone


  notification_settings {
    enabled = false
  }
  tags = merge(local.default_tags, var.extra_tags)
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}