variable "location" {
  default     = "eastus"
  description = "Location of the resources (Default: eastus)."
}

variable "name" {
  description = "Name for the subnet"
}

variable "resource_group_name" {
  description = "Name of the ressource group this VMs belonging to"
}

variable "virtual_network_name" {
  description = "Name of the parent network"
}

variable "address_prefixes" {
  description = "Subnet address range"
}
