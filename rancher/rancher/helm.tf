# Helm resources
resource "null_resource" "wait_kubeconfig" {
  provisioner "local-exec" {
    command = "while [ ! -f ${var.kubeconfig_path} ]; do echo Waiting for ${var.kubeconfig_path} to be available; sleep 10; done"
  }
}

var.kubeconfig_path

# Install cert-manager helm chart
resource "helm_release" "cert_manager" {
  depends_on      = [null_resource.wait_kubeconfig]
  name             = "cert-manager"
  chart            = "https://charts.jetstack.io/charts/cert-manager-v${var.cert_manager_version}.tgz"
  namespace        = "cert-manager"
  create_namespace = true
  wait             = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}

# Install Rancher helm chart
resource "helm_release" "rancher_server" {
  depends_on = [
    helm_release.cert_manager,
  ]

  name             = "rancher"
  chart            = "https://releases.rancher.com/server-charts/latest/rancher-${var.rancher_version}.tgz"
  namespace        = "cattle-system"
  create_namespace = true
  wait             = true

  set {
    name  = "hostname"
    value = var.rancher_server_dns
  }

  set {
    name  = "replicas"
    value = "1"
  }

  set {
    name  = "bootstrapPassword"
    value = "admin" # TODO: change this once the terraform provider has been updated with the new pw bootstrap logic
  }
}
