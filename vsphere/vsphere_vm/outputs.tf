output "VM" {
  description = "VM Names"
  value       = vsphere_virtual_machine.*.*.name
}

output "ip" {
  description = "default ip address of the deployed VM"
  value       = vsphere_virtual_machine.*.*.default_ip_address
}

output "guest-ip" {
  description = "all the registered ip address of the VM"
  value       = vsphere_virtual_machine.*.*.guest_ip_addresses
}

output "uuid" {
  description = "UUID of the VM in vSphere"
  value       = vsphere_virtual_machine.*.*.uuid
}

output "disk" {
  description = "Disks of the deployed VM"
  value       = vsphere_virtual_machine.*.*.disk
}