variable "cert_manager_version" {
  type        = string
  description = "Version of cert-manager to install alongside Rancher (format: 0.0.0)"
  default     = "1.7.1"
}

variable "rancher_version" {
  type        = string
  description = "Rancher server version (format v0.0.0)"
  default     = "2.6.8"
}

# Required
variable "rancher_server_dns" {
  type        = string
  description = "DNS host name of the Rancher server"
}

# Required
variable "admin_password" {
  type        = string
  description = "Admin password to use for Rancher server bootstrap, min. 12 characters"
}

variable "workload_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for managed workload cluster"
  default     = "v1.23.9+rke2r1"
}

# Required
variable "workload_cluster_name" {
  type        = string
  description = "Name for created custom workload cluster"
}

variable "servernodes" {
  description = "Map of IP addresses of the server nodes. Must be an odd number of IP addresses."
  type        = list(string)

  validation {
    condition     = length(var.servernodes) % 2 != 0
    error_message = "You must specify an odd number of server nodes."
  }
}
variable "agentnodes" {
  description = "Map of IP addresses of the server nodes. (Defaults to: `{}`). If empty, all server nodes will also be agent nodes"
  type        = list(string)
  default     = []
}
variable "kubeconfig_path" {
  description = "Path where the kubeconfig should be written to (Defaults to: `~/kube_config.yaml`)"
  type        = string
  default     = "~/kube_config.yaml"
}