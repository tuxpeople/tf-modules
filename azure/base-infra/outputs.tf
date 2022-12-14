output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "Resource group name"
}

output "resource_group_id" {
  value       = azurerm_resource_group.main.id
  description = "Resource group generated id"
}

output "resource_group_location" {
  value       = azurerm_resource_group.main.location
  description = "Resource group location (region)"
}

output "virtual_network_name" {
  value       = try(azurerm_virtual_network.main[0].name, "")
  description = "Virtual network name"
}

output "virtual_network_id" {
  value       = try(azurerm_virtual_network.main[0].id, "")
  description = "Virtual network generated id"
}
