output "resource_group_name" {
  value       = azurerm_resource_group.this.name
  description = "Resource group name"
}

output "resource_group_id" {
  value       = azurerm_resource_group.this.id
  description = "Resource group generated id"
}

output "resource_group_location" {
  value       = azurerm_resource_group.this.location
  description = "Resource group location (region)"
}

output "virtual_network_name" {
  value       = azurerm_virtual_network.this.name
  description = "Virtual network name"
}

output "virtual_network_id" {
  value       = azurerm_virtual_network.this.id
  description = "Virtual network generated id"
}
