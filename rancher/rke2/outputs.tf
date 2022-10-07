output "cluster_token" {
  description = "Map of latest RKE2 releases per channel."
  value       = random_password.cluster-token.result
}
output "kubeconfig_path" {
  description = "Path of the kubeconfig"
  value       = var.kubeconfig_path
}
