output "VM" {
  description = "VM Names"
  value       = proxmox_virtual_environment_vm.main[*].name
}

output "ip" {
  description = "Default IP addresses of the deployed VMs"
  value       = proxmox_virtual_environment_vm.main[*].ipv4_addresses
}

output "vm_id" {
  description = "VM IDs in Proxmox"
  value       = proxmox_virtual_environment_vm.main[*].vm_id
}

output "node_name" {
  description = "Proxmox node names where VMs are deployed"
  value       = proxmox_virtual_environment_vm.main[*].node_name
}

output "disk" {
  description = "Disk configuration of the deployed VMs"
  value       = proxmox_virtual_environment_vm.main[*].disk
}

output "mac_addresses" {
  description = "MAC addresses of the VMs"
  value       = [for vm in proxmox_virtual_environment_vm.main : vm.network_device[0].mac_address]
}

output "instances" {
  description = "Per-instance connection info (name, vm_id, ipv4)"
  value = [
    for vm in proxmox_virtual_environment_vm.main : {
      name  = vm.name
      vm_id = vm.id
      ipv4 = can(vm.ipv4_addresses[1][0]) ? split("/", vm.ipv4_addresses[1][0])[0] : (
        can(vm.ipv4_addresses[0][0]) ? split("/", vm.ipv4_addresses[0][0])[0] : null
      )
    }
  ]
}
