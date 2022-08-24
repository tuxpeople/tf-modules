output "subnet_name" {
  value       = azurerm_subnet.this.name
  description = "Subnet name"
}

output "subnet_id" {
  value       = azurerm_subnet.this.id
  description = "Subnet generated id"
}