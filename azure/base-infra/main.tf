resource "random_pet" "main" {
  count  = var.enable_pets == true ? 1 : 0
  prefix = "${var.resource_group_name_prefix}-${var.project}"
}

resource "azurerm_resource_group" "main" {
  name     = var.enable_pets == true ? random_pet.main.0.id : "${var.resource_group_name_prefix}-${var.project}"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  count               = var.address_space != "" ? 1 : 0
  name                = "${var.project}-network"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}