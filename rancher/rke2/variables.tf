variable "servernodes" {
  description = "Map of IP addresses of the server nodes. Must be an odd number of IP addresses."
  type        = list(string)

  validation {
    condition     = length(var.servernodes) % 2 != 0
    error_message = "You must specify an odd number of server nodes."
  }
}
variable "agentnodes" {
  description = "Map of IP addresses of the server nodes. (Defaults to: `[]`). If empty, all server nodes will also be agent nodes"
  type        = list(string)
  default     = []
}
variable "kubeconfig_path" {
  description = "Path where the kubeconfig should be written to (Defaults to: `~/kube_config.yaml`)"
  type        = string
  default     = "~/kube_config.yaml"
}
variable "vip_address" {
  description = "VIP ip for Kubernetes API"
  type        = string
}
variable "kube_vip" {
  description = "Wether or not kube_vip should be deployed. (Defaults to: `true`)"
  type        = bool
  default     = true
}
variable "vip_fqdn" {
  description = "FQDN of the VIP ipadress"
  type        = string
}
variable "ssh_user_agent" {
  description = "Username for ssh to agent nodes"
  type        = string
}
variable "ssh_key_agent" {
  description = "Private key for ssh agent nodes"
  type        = string
}
variable "ssh_user_server" {
  description = "Username for ssh to server nodes"
  type        = string
}
variable "ssh_key_server" {
  description = "Private key for ssh server nodes"
  type        = string
}
variable "network_interface" {
  description = "Network interface for kube_vip (Defaults to `ens192`)"
  type        = string
  default     = "ens192"
}