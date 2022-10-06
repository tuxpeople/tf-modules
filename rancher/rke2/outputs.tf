output "cluster_token" {
  description = "Map of latest RKE2 releases per channel."
  value       = random_password.cluster-token.result
}