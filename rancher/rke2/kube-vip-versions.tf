data "http" "kubevip_available_versions" {
  url = "https://api.github.com/repos/kube-vip/kube-vip/releases"

  request_headers = {
    accept = "vnd.github.v3+json"
  }
}

locals {
  kubevip_available_versions = local.kubevip_data.*.tag_name
  kubevip_data               = jsondecode(data.http.kubevip_available_versions.body)
}