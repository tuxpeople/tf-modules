data "http" "rke2_channels" {
  url = "https://update.rke2.io/v1-release/channels"

  request_headers = {
    accept = "application/json"
  }
}

locals {
  rke2_data     = jsondecode(data.http.rke2_available_versions.body)
  rke2_list     = { for channels in local.rke2_data.data : channels.id => channels.latest }
  rke2_channels = keys(local.rke2_list)
  rke2_version  = lookup(local.rke2_list, var.rke2_channel, "")
}