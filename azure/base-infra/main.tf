resource "random_pet" "this" {
  count  = var.enable_pets == true ? 1 : 0
  prefix = "${var.resource_group_name_prefix}-${var.project}"
}

resource "azurerm_resource_group" "this" {
  name     = var.enable_pets == true ? random_pet.this.0.id : "${var.resource_group_name_prefix}-${var.project}"
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.project}-network"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
}