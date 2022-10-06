<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | 2.2.1 |

## Providers

| Name | Version |
|------|---------|
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
| <a name="input_servernodes"></a> [servernodes](#input\_servernodes) | Map of IP addresses of the server nodes. Must be an odd number of IP addresses. | `list(string)` | n/a | yes |
| <a name="input_ssh_key_agent"></a> [ssh\_key\_agent](#input\_ssh\_key\_agent) | Private key for ssh agent nodes | `string` | n/a | yes |
| <a name="input_ssh_key_server"></a> [ssh\_key\_server](#input\_ssh\_key\_server) | Private key for ssh server nodes | `string` | n/a | yes |
| <a name="input_ssh_user_agent"></a> [ssh\_user\_agent](#input\_ssh\_user\_agent) | Username for ssh to agent nodes | `string` | n/a | yes |
| <a name="input_ssh_user_server"></a> [ssh\_user\_server](#input\_ssh\_user\_server) | Username for ssh to server nodes | `string` | n/a | yes |
| <a name="input_vip_address"></a> [vip\_address](#input\_vip\_address) | VIP ip for Kubernetes API | `string` | n/a | yes |
| <a name="input_vip_fqdn"></a> [vip\_fqdn](#input\_vip\_fqdn) | FQDN of the VIP ipadress | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->