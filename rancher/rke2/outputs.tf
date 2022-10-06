output "RKE2 Channels" {
  description = "Full list of available RKE2 release channels"
  value       = local.rke2_channels
}
output "RKE2 Releases" {
  description = "Map of latest RKE2 releases per channel."
  value       = local.rke2_list
}