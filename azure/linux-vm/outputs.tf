
output "linux_vm_public_ips" {
  description = "Public IP's map for the all Virtual Machines"
  value       = var.enable_public_ip_address == true ? zipmap(azurerm_linux_virtual_machine.this.*.name, azurerm_linux_virtual_machine.this.*.public_ip_address) : null
}

output "linux_vm_private_ips" {
  description = "Public IP's map for the all Virtual Machines"
  value       = zipmap(azurerm_linux_virtual_machine.this.*.name, azurerm_linux_virtual_machine.this.*.private_ip_address)
}

output "linux_virtual_machine_ids" {
  description = "The resource id's of all Linux Virtual Machine."
  value       = concat(azurerm_linux_virtual_machine.this.*.id, [""])
}

output "public_ips" {
  description = "DNS Name of the public IPs"
  value       = zipmap(azurerm_public_ip.this.*.ip_address, azurerm_public_ip.this.*.fqdn)
}

output "vm_details" {
  description = "Detailed information about all VMs"
  value = [
    for i, vm in azurerm_linux_virtual_machine.this : {
      name                = vm.name
      public_ip_address   = vm.public_ip_address
      private_ip_address  = vm.private_ip_address
      fqdn                = lookup(zipmap(azurerm_public_ip.this.*.ip_address, azurerm_public_ip.this.*.fqdn), "${vm.public_ip_address}", null)
      location            = vm.location
      resource_group_name = vm.resource_group_name
    }
  ]
}
