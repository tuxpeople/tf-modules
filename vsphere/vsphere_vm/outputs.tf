output "VM" {
  description = "VM Names"
  value       = try(vsphere_virtual_machine.local.*.name, vsphere_virtual_machine.ovf.*.name)
}

output "ip" {
  description = "default ip address of the deployed VM"
  value       = try(vsphere_virtual_machine.local.*.default_ip_address, vsphere_virtual_machine.ovf.*.default_ip_address)
}

output "guest-ip" {
  description = "all the registered ip address of the VM"
  value       = try(vsphere_virtual_machine.local.*.guest_ip_addresses, vsphere_virtual_machine.ovf.*.guest_ip_addresses)
}

output "uuid" {
  description = "UUID of the VM in vSphere"
  value       = try(vsphere_virtual_machine.local.*.uuid, vsphere_virtual_machine.ovf.*.uuid)
}

output "disk" {
  description = "Disks of the deployed VM"
  value       = try(vsphere_virtual_machine.local.*.disk, vsphere_virtual_machine.ovf.*.disk)
}