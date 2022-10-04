<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.5.1 |
| <a name="requirement_rancher2"></a> [rancher2](#requirement\_rancher2) | 1.24.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | 2.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.5.1 |
| <a name="provider_rancher2.admin"></a> [rancher2.admin](#provider\_rancher2.admin) | 1.24.0 |
| <a name="provider_rancher2.bootstrap"></a> [rancher2.bootstrap](#provider\_rancher2.bootstrap) | 1.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/2.5.1/docs/resources/release) | resource |
| [helm_release.rancher_server](https://registry.terraform.io/providers/hashicorp/helm/2.5.1/docs/resources/release) | resource |
| [rancher2_bootstrap.admin](https://registry.terraform.io/providers/rancher/rancher2/1.24.0/docs/resources/bootstrap) | resource |
| [rancher2_cluster_v2.quickstart_workload](https://registry.terraform.io/providers/rancher/rancher2/1.24.0/docs/resources/cluster_v2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Admin password to use for Rancher server bootstrap, min. 12 characters | `string` | n/a | yes |
| <a name="input_agentnodes"></a> [agentnodes](#input\_agentnodes) | Map of IP addresses of the server nodes. (Defaults to: `{}`). If empty, all server nodes will also be agent nodes | `list(string)` | `[]` | no |
| <a name="input_cert_manager_version"></a> [cert\_manager\_version](#input\_cert\_manager\_version) | Version of cert-manager to install alongside Rancher (format: 0.0.0) | `string` | `"1.7.1"` | no |
| <a name="input_kubeconfig_path"></a> [kubeconfig\_path](#input\_kubeconfig\_path) | Path where the kubeconfig should be written to (Defaults to: `~/kube_config.yaml`) | `string` | `"~/kube_config.yaml"` | no |
| <a name="input_rancher_server_dns"></a> [rancher\_server\_dns](#input\_rancher\_server\_dns) | DNS host name of the Rancher server | `string` | n/a | yes |
| <a name="input_rancher_version"></a> [rancher\_version](#input\_rancher\_version) | Rancher server version (format v0.0.0) | `string` | `"2.6.8"` | no |
| <a name="input_servernodes"></a> [servernodes](#input\_servernodes) | Map of IP addresses of the server nodes. Must be an odd number of IP addresses. | `list(string)` | n/a | yes |
| <a name="input_workload_cluster_name"></a> [workload\_cluster\_name](#input\_workload\_cluster\_name) | Name for created custom workload cluster | `string` | n/a | yes |
| <a name="input_workload_kubernetes_version"></a> [workload\_kubernetes\_version](#input\_workload\_kubernetes\_version) | Kubernetes version to use for managed workload cluster | `string` | `"v1.23.9+rke2r1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_cluster_command"></a> [custom\_cluster\_command](#output\_custom\_cluster\_command) | Docker command used to add a node to the quickstart cluster |
| <a name="output_custom_cluster_windows_command"></a> [custom\_cluster\_windows\_command](#output\_custom\_cluster\_windows\_command) | Docker command used to add a windows node to the quickstart cluster |
| <a name="output_rancher_url"></a> [rancher\_url](#output\_rancher\_url) | n/a |
<!-- END_TF_DOCS -->