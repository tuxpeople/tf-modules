<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | 2.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.deploy-kubevip](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.deploy-rke2-server-config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.deploy-rke2-worker-config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.set_initial_state](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_pet.pet](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [ssh_resource.deploy-first-servernode](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [ssh_resource.install-agent-nodes](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [ssh_resource.other-servernodes](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |
| [ssh_resource.retrieve_config_management](https://registry.terraform.io/providers/loafoe/ssh/2.2.1/docs/resources/resource) | resource |

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