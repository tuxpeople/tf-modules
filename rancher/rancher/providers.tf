terraform {
  required_providers {
    ssh = {
      source  = "loafoe/ssh"
      version = "2.7.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "7.3.2"
    }
  }
}
# Rancher2 bootstrapping provider
provider "rancher2" {
  alias = "bootstrap"

  api_url  = "https://${var.rancher_server_dns}"
  insecure = true
  # ca_certs  = data.kubernetes_secret.rancher_cert.data["ca.crt"]
  bootstrap = true
}

# Rancher2 administration provider
provider "rancher2" {
  alias = "admin"

  api_url  = "https://${var.rancher_server_dns}"
  insecure = true
  # ca_certs  = data.kubernetes_secret.rancher_cert.data["ca.crt"]
  token_key = rancher2_bootstrap.admin.token
  timeout   = "300s"
}
provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}