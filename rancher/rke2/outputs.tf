output "RKE2 Channels" {
  description = "Full list of available RKE2 release channels"
  value       = local.rke2_channels
}
output "RKE2 Releases" {
  description = "Map of latest RKE2 releases per channel."
  value       = local.rke2_list
}
output "cluster_token" {
  description = "Map of latest RKE2 releases per channel."
  value       = random_password.cluster-token.result
}