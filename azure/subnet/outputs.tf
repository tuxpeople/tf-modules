output "subnet_name" {
  value       = azurerm_subnet.main.name
  description = "Subnet name"
}

output "subnet_id" {
  value       = azurerm_subnet.main.id
  description = "Subnet generated id"
}