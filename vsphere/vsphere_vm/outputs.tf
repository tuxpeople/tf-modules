output "VM" {
  description = "VM Names"
  value       = vsphere_virtual_machine.main.*.name
}

output "ip" {
  description = "default ip address of the deployed VM"
  value       = vsphere_virtual_machine.main.*.default_ip_address
}

output "guest-ip" {
  description = "all the registered ip address of the VM"
  value       = vsphere_virtual_machine.main.*.guest_ip_addresses
}

output "uuid" {
  description = "UUID of the VM in vSphere"
  value       = vsphere_virtual_machine.main.*.uuid
}

output "disk" {
  description = "Disks of the deployed VM"
  value       = vsphere_virtual_machine.main.*.disk
}