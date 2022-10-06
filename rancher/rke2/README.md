<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | 2.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.2.1 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_password.cluster-token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [ssh_resource.deploy-first-servernode](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [ssh_resource.deploy-kubevip](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [ssh_resource.deploy-other-servernodes](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [ssh_resource.install-agent-nodes](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [ssh_resource.retrieve_config_management](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [ssh_resource.rke2_agent_config](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [ssh_resource.rke2_agent_config_dir](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [ssh_resource.rke2_server_config](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [ssh_resource.rke2_server_config_dir](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [http_http.kubevip_available_versions](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.rke2_channels](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [template_file.kubevip_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.rke2_agent_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.rke2_server_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agentnodes"></a> [agentnodes](#input\_agentnodes) | Map of IP addresses of the server nodes. (Defaults to: `[]`). If empty, all server nodes will also be agent nodes | `list(string)` | `[]` | no |
| <a name="input_kube_vip"></a> [kube\_vip](#input\_kube\_vip) | Wether or not kube\_vip should be deployed. (Defaults to: `true`) | `bool` | `true` | no |
| <a name="input_kubeconfig_path"></a> [kubeconfig\_path](#input\_kubeconfig\_path) | Path where the kubeconfig should be written to (Defaults to: `~/kube_config.yaml`) | `string` | `"~/kube_config.yaml"` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | Network interface for kube\_vip (Defaults to `ens192`) | `string` | `"ens192"` | no |
| <a name="input_rke2_channel"></a> [rke2\_channel](#input\_rke2\_channel) | Which RKE2 release channel to use, will install latest version from this channel. Possible values include `latest`, `stable`, `testing`, `v1.25` etc. (see https://github.com/rancher/rke2/blob/master/channels.yaml, defaults to: `stable`) | `string` | `"stable"` | no |
| <a name="input_servernodes"></a> [servernodes](#input\_servernodes) | Map of IP addresses of the server nodes. Must be an odd number of IP addresses. | `list(string)` | n/a | yes |
| <a name="input_ssh_key_agent"></a> [ssh\_key\_agent](#input\_ssh\_key\_agent) | Private key for ssh agent nodes | `string` | n/a | yes |
| <a name="input_ssh_key_server"></a> [ssh\_key\_server](#input\_ssh\_key\_server) | Private key for ssh server nodes | `string` | n/a | yes |
| <a name="input_ssh_user_agent"></a> [ssh\_user\_agent](#input\_ssh\_user\_agent) | Username for ssh to agent nodes | `string` | n/a | yes |
| <a name="input_ssh_user_server"></a> [ssh\_user\_server](#input\_ssh\_user\_server) | Username for ssh to server nodes | `string` | n/a | yes |
| <a name="input_vip_address"></a> [vip\_address](#input\_vip\_address) | VIP ip for Kubernetes API | `string` | n/a | yes |
| <a name="input_vip_fqdn"></a> [vip\_fqdn](#input\_vip\_fqdn) | FQDN of the VIP ipadress | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_token"></a> [cluster\_token](#output\_cluster\_token) | Map of latest RKE2 releases per channel. |
| <a name="output_rke2_channels"></a> [rke2\_channels](#output\_rke2\_channels) | Full list of available RKE2 release channels |
| <a name="output_rke2_releases"></a> [rke2\_releases](#output\_rke2\_releases) | Map of latest RKE2 releases per channel. |
<!-- END_TF_DOCS -->