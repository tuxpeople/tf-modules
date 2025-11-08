variable "proxmox_endpoint" {
  description = "Proxmox VE API endpoint URL"
  type        = string
}

variable "proxmox_username" {
  description = "Proxmox VE username"
  type        = string
}

variable "proxmox_ssh_username" {
  description = "Proxmox VE SSH username (usually 'root')"
  type        = string
  default     = "root"
}

variable "proxmox_ssh_private_key" {
  description = "Path to SSH private key for Proxmox access"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "proxmox_password" {
  description = "Proxmox VE password"
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Skip TLS verification for Proxmox API"
  type        = bool
  default     = false
}

variable "instances_count" {
  description = "Number of VM instances to create"
  type        = number
  default     = 1
}

variable "hostname" {
  description = "Base hostname for the VMs"
  type        = string
  default     = "test-vm"
}

variable "node_name" {
  description = "Proxmox node name where VMs should be created"
  type        = string
}

variable "vcpu" {
  description = "Number of vCPU cores"
  type        = number
  default     = 2
}

variable "vmem" {
  description = "Amount of memory in MB"
  type        = number
  default     = 2048
}

variable "disksize" {
  description = "Disk size in GB"
  type        = number
  default     = 20
}

variable "datastore_id" {
  description = "Datastore ID for VM storage"
  type        = string
  default     = "local-lvm"
}

variable "snippets_datastore_id" {
  description = "Datastore for cloud-init snippets"
  type        = string
  default     = "local"
}

variable "network_bridge" {
  description = "Network bridge name"
  type        = string
  default     = "vmbr0"
}

variable "template" {
  description = "Template to use for VM creation"
  type        = string
  default     = ""
}

variable "iso_file" {
  description = "ISO file for VM installation"
  type        = string
  default     = ""
}

variable "distro" {
  description = "Operating system distribution"
  type        = string
  default     = "ubuntu"
}

variable "enable_vendor_config" {
  description = "Enable vendor config for distro-specific setup"
  type        = bool
  default     = true
}

variable "domain" {
  description = "Domain name for the VMs"
  type        = string
  default     = "lab.tdeutsch.ch"
}

variable "ip_addresses" {
  description = "Static IP addresses (CIDR notation) or empty for DHCP"
  type        = list(string)
  default     = [""]
}

variable "gateway" {
  description = "Gateway IP address"
  type        = string
  default     = ""
}

variable "dns_servers" {
  description = "DNS server addresses"
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "ssh_public_keyfile" {
  description = "Path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "tags" {
  description = "Tags to apply to VMs"
  type        = list(string)
  default     = ["terraform", "test"]
}