variable "enable_pets" {
  default = "false"
}

variable "location" {
  default     = "eastus"
  description = "Location of the resources (Default: eastus)."
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with the project name"
}

variable "project" {
  description = "Name for that project"
}

variable "address_space" {
  description = "Adress space for the network"
}