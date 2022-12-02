variable "instances_count" {
  description = "How many of those VM instances? (Default: 1)"
  type        = string
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
  description = "Which template to clone. (Defaults to: linux-ubuntu-server-22-04-lts)"
  type        = string
  default     = "linux-ubuntu-server-22-04-lts"
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
variable "redhat_username" {
  description = "Username to subscribe a RHEL system to RedHat (used when guest_id == rhel8_64Guest)"
  type        = string
  default     = ""
}
variable "redhat_password" {
  description = "Password to subscribe a RHEL system to RedHat (used when guest_id == rhel8_64Guest)"
  type        = string
  default     = ""
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
variable "ssh_private_keyfile" {
  description = "SSH private keyfile for the VMs (Default: ~/.ssh/id_rsa)"
  type        = string
  default     = "~/.ssh/id_rsa"
}
variable "wait_for_guest_net_routable" {
  description = "Controls whether or not the guest network waiter waits for a routable address. (Defaults to: true)"
  type        = bool
  default     = true
}
variable "wait_for_guest_net_timeout" {
  description = "The amount of time, in minutes, to wait for an available guest IP address on the virtual machine (Defaults to: 5)"
  type        = number
  default     = "5"
}
variable "domain" {
  description = "local domain (Defaults to: lab.tdeutsch.ch)"
  type        = string
  default     = "lab.tdeutsch.ch"
}
variable "content_library" {
  description = "Name of the content library where the OVF template is stored."
  type = string
  default     = null
}