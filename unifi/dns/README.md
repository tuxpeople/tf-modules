<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.copy-dns](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.refresh-dns](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_pet.pet](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addressrecord"></a> [addressrecord](#input\_addressrecord) | Map of address records (Defaults to {}) Eg: {name = "Mabel", age = 52} | `map(any)` | `{}` | no |
| <a name="input_cnamerecord"></a> [cnamerecord](#input\_cnamerecord) | Map of cname records (Defaults to {}) Eg: {name = "Mabel", age = 52} | `map(any)` | `{}` | no |
| <a name="input_dnsserver"></a> [dnsserver](#input\_dnsserver) | Host of DNS server (Defaults to 10.20.30.1) | `string` | `"10.20.30.1"` | no |
| <a name="input_hostrecord"></a> [hostrecord](#input\_hostrecord) | Map of host records (Defaults to {}) Eg: {name = "Mabel", age = 52} | `map(any)` | `{}` | no |
| <a name="input_serverrecord"></a> [serverrecord](#input\_serverrecord) | Map of server records (Defaults to {}) Eg: {name = "Mabel", age = 52} | `map(any)` | `{}` | no |
| <a name="input_sshkey"></a> [sshkey](#input\_sshkey) | Path to ssh-key (Defaults to ~/.ssh/id\_rsa) | `string` | `"~/.ssh/id_rsa"` | no |
| <a name="input_sshuser"></a> [sshuser](#input\_sshuser) | SSH Username (Defaults to root) | `string` | `"root"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dnsfile"></a> [dnsfile](#output\_dnsfile) | Full path of created dns file |
<!-- END_TF_DOCS -->