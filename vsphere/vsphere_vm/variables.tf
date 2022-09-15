variable "instances_count" {
  description = "How many of those VM instances? (Default: 1)"
  type        = number
  default     = "1"
}
variable "vCPU" {
  description = "How many vCPU"
  type        = number
}
variable "vMEM" {
  description = "How many vMEM"
  type        = number
}
variable "disksize" {
  description = "Disksize in GB"
  type        = number
}
variable "thin_provisioned" {
  description = "Thinprovision the disk (Defaults to: true)"
  type        = bool
  default     = true
}
variable "eagerly_scrub" {
  description = "Eagerly scrub disk (Defaults to: false)"
  type        = bool
  default     = false
}
variable "folder" {
  description = "Folder where the VMs should be placed (must exist)"
  type        = string
}
variable "datastore" {
  description = "Datastore where the VMs should be placed (must exist)"
  type        = string
}
variable "network" {
  description = "Network which the VM should be connected to (must exist)"
  type        = string
}
variable "template" {
  description = "Which template to clone. (Defaults to: focal-server-cloudimg-amd64)"
  type        = string
  default     = "focal-server-cloudimg-amd64"
}
variable "cluster" {
  description = "Cluster where the VMs should be placed (Defaults to: Homelab)"
  type        = string
  default     = "Homelab"
}
variable "datacenter" {
  description = "Datacenter where the VMs should be placed (Defaults to: SKY)"
  type        = string
  default     = "SKY"
}
variable "hostname" {
  description = "Hostname of the VM, will be appended with a number depending on how many VMs beeing created."
  type        = string
}
variable "user_data" {
  description = "Supply a special cloud-init file. If empty, the module's default will be used."
  type        = string
  default     = ""
}
variable "guest_id" {
  description = "guest_id of the VM (Defaults to: ubuntu64Guest)"
  type        = string
  default     = "ubuntu64Guest"
}
variable "ssh_public_keyfile" {
  description = "SSH public keyfile for the VMs (Default: ~/.ssh/id_rsa.pub)"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}