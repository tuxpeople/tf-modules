output "vm_names" {
  description = "Names of the created VMs"
  value       = module.test_vm.VM
}

output "vm_ip_addresses" {
  description = "IP addresses of the created VMs"
  value       = module.test_vm.ip
}

output "vm_ids" {
  description = "Proxmox VM IDs"
  value       = module.test_vm.vm_id
}

output "vm_nodes" {
  description = "Proxmox nodes where VMs are deployed"
  value       = module.test_vm.node_name
}

output "vm_mac_addresses" {
  description = "MAC addresses of the VMs"
  value       = module.test_vm.mac_addresses
}