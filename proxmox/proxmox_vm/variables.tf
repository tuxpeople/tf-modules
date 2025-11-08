variable "instances_count" {
  description = "How many of those VM instances? (Default: 1)"
  type        = number
  default     = 1
}

variable "vCPU" {
  description = "How many vCPU cores"
  type        = number
}

variable "vMEM" {
  description = "How much vMEM in MB"
  type        = number
}

variable "disksize" {
  description = "Disksize in GB"
  type        = number
}

variable "hostname" {
  description = "Hostname of the VM, will be appended with a number depending on how many VMs being created."
  type        = string
}

variable "node_name" {
  description = "Proxmox node where the VMs should be placed"
  type        = string
}

variable "datastore_id" {
  description = "Datastore where the VMs should be placed"
  type        = string
  default     = "local-lvm"
}

variable "template_datastore_id" {
  description = "Datastore where the template is stored (defaults to datastore_id)"
  type        = string
  default     = ""
}

variable "snippets_datastore_id" {
  description = "Datastore for cloud-init snippets (must support file storage, defaults to 'local')"
  type        = string
  default     = "local"
}

variable "network_bridge" {
  description = "Network bridge which the VM should be connected to"
  type        = string
  default     = "vmbr0"
}

variable "vlan_ids" {
  description = "Optional VLAN IDs per VM (must align with instances_count when provided)"
  type        = list(number)
  default     = []
}

variable "template" {
  description = "Template to clone from (template ID or empty for no template)"
  type        = string
  default     = ""
}

variable "iso_file" {
  description = "ISO file ID for VM installation (e.g., 'local:iso/ubuntu-22.04-server-amd64.iso')"
  type        = string
  default     = ""
}

variable "pool_id" {
  description = "Resource pool where the VMs should be placed"
  type        = string
  default     = ""
}

variable "cpu_type" {
  description = "CPU type (Default: host)"
  type        = string
  default     = "host"
}

variable "os_type" {
  description = "Operating system type (Default: l26)"
  type        = string
  default     = "l26"
}

variable "user_data" {
  description = "Supply a special cloud-init file. If empty, the module's default will be used."
  type        = string
  default     = ""
}

variable "external_user_data_file_ids" {
  description = "Optional user-data file IDs to use instead of rendering new snippets (length must cover instances_count)"
  type        = list(string)
  default     = []
}

variable "external_meta_data_file_ids" {
  description = "Optional meta-data file IDs to use instead of rendering new snippets (length must cover instances_count)"
  type        = list(string)
  default     = []
}

variable "external_vendor_data_file_ids" {
  description = "Optional vendor-data file IDs to use when enable_vendor_config is true"
  type        = list(string)
  default     = []
}

variable "ssh_public_keyfile" {
  description = "SSH public keyfile for the VMs (Default: ~/.ssh/id_rsa.pub)"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_keyfile" {
  description = "SSH private keyfile for connecting to VMs (Default: ~/.ssh/id_rsa)"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "stop_on_destroy" {
  description = "Stop VM before destroying (Default: true)"
  type        = bool
  default     = true
}

variable "agent_enabled" {
  description = "Enable QEMU guest agent (Default: true)"
  type        = bool
  default     = true
}

variable "startup_order" {
  description = "VM startup order (Default: 3)"
  type        = string
  default     = "3"
}

variable "startup_up_delay" {
  description = "Startup up delay in seconds (Default: 60)"
  type        = string
  default     = "60"
}

variable "startup_down_delay" {
  description = "Startup down delay in seconds (Default: 60)"
  type        = string
  default     = "60"
}

variable "enable_provisioner" {
  description = "Enable remote-exec provisioner to wait for cloud-init (Default: false)"
  type        = bool
  default     = false
}

variable "distro" {
  description = "Operating system distribution (ubuntu, rocky, debian, centos, fedora)"
  type        = string
  default     = "ubuntu"

  validation {
    condition     = contains(["ubuntu", "rocky", "debian", "centos", "fedora"], var.distro)
    error_message = "Distro must be one of: ubuntu, rocky, debian, centos, fedora."
  }
}

variable "enable_vendor_config" {
  description = "Enable vendor config for distro-specific setup (Default: true)"
  type        = bool
  default     = true
}

variable "disks" {
  description = "Optional list of disk definitions (datastore_id, file_id, interface, iothread, discard, size). When empty, a single default disk is created."
  type = list(object({
    datastore_id = string
    file_id      = string
    interface    = string
    iothread     = bool
    discard      = string
    size         = number
  }))
  default = []
}

variable "domain" {
  description = "local domain (Defaults to: lab.tdeutsch.ch)"
  type        = string
  default     = "lab.tdeutsch.ch"
}

variable "mac_address" {
  description = "MAC Addresses for the VMs"
  type        = list(string)
  default     = [""]
}

variable "ip_addresses" {
  description = "Static IP addresses for the VMs (CIDR notation, e.g., 192.168.1.100/24). Use empty string for DHCP."
  type        = list(string)
  default     = [""]
}

variable "gateway" {
  description = "Gateway IP address"
  type        = string
  default     = ""
}

variable "dns_servers" {
  description = "DNS servers"
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "tags" {
  description = "Tags to attach to the VMs"
  type        = list(string)
  default     = []
}

variable "cloud_init_wait" {
  description = "Optional configuration to wait for cloud-init completion via local script"
  type = object({
    enabled         = bool
    script_path     = string
    ssh_user        = string
    ssh_private_key = string
    reboot_delay    = number
    timeout         = number
  })
  default = null
}
