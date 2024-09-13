<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dev_test_global_vm_shutdown_schedule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dev_test_global_vm_shutdown_schedule) | resource |
| [azurerm_linux_virtual_machine.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.nsg_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [random_string.unique_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_init_file"></a> [cloud\_init\_file](#input\_cloud\_init\_file) | Path to cloud-init file for the VMs. <FQDN> and <HOSTNAME> can be used as variables and will be replaced. (optional) | `string` | `""` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | Supply the prepared cloud-init data for the VM in plain text. If set <cloud\_init\_file> will be ignored. (optional) | `string` | `""` | no |
| <a name="input_custom_data_vars"></a> [custom\_data\_vars](#input\_custom\_data\_vars) | Custom variables to replace in <cloud\_init\_file> to replace <FQDN> and <HOSTNAME> with. (optional) | `map(string)` | `{}` | no |
| <a name="input_default_tags_enabled"></a> [default\_tags\_enabled](#input\_default\_tags\_enabled) | Option to enable or disable default tags. | `bool` | `true` | no |
| <a name="input_dns_domain"></a> [dns\_domain](#input\_dns\_domain) | Domain part of the FQDN. Will be appended to <dns\_name>. (Default: <location>.cloudapp.azure.com) | `string` | `""` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | Hostname for the FQDN, needs to be unique for the whole domain and will be appended with a number depending on how many VMs beeing created. (Default: VM name with number and a random suffix) | `string` | `""` | no |
| <a name="input_enable_public_ip_address"></a> [enable\_public\_ip\_address](#input\_enable\_public\_ip\_address) | Do this VMs need a public IP address (Default: false) | `bool` | `false` | no |
| <a name="input_enable_reverse_fqdn"></a> [enable\_reverse\_fqdn](#input\_enable\_reverse\_fqdn) | Do this VMs public IP addresses need a reverse FQDN (Default: false) | `bool` | `false` | no |
| <a name="input_enable_vm_shutdown"></a> [enable\_vm\_shutdown](#input\_enable\_vm\_shutdown) | Should auto-shutdown be enabled for this VMs (Default: false) | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment of the resources (Default: development). | `string` | `"development"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Additional tags to associate with your VMs. | `map(string)` | `{}` | no |
| <a name="input_instances_count"></a> [instances\_count](#input\_instances\_count) | How many of those VM instances? (Default: 1) | `string` | `"1"` | no |
| <a name="input_linux_distribution_list"></a> [linux\_distribution\_list](#input\_linux\_distribution\_list) | Pre-defined Azure Linux VM images list | <pre>map(object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  }))</pre> | <pre>{<br>  "centos77": {<br>    "offer": "CentOS",<br>    "publisher": "OpenLogic",<br>    "sku": "7.7",<br>    "version": "latest"<br>  },<br>  "centos78-gen2": {<br>    "offer": "CentOS",<br>    "publisher": "OpenLogic",<br>    "sku": "7_8-gen2",<br>    "version": "latest"<br>  },<br>  "centos79-gen2": {<br>    "offer": "CentOS",<br>    "publisher": "OpenLogic",<br>    "sku": "7_9-gen2",<br>    "version": "latest"<br>  },<br>  "centos81": {<br>    "offer": "CentOS",<br>    "publisher": "OpenLogic",<br>    "sku": "8_1",<br>    "version": "latest"<br>  },<br>  "centos81-gen2": {<br>    "offer": "CentOS",<br>    "publisher": "OpenLogic",<br>    "sku": "8_1-gen2",<br>    "version": "latest"<br>  },<br>  "centos82-gen2": {<br>    "offer": "CentOS",<br>    "publisher": "OpenLogic",<br>    "sku": "8_2-gen2",<br>    "version": "latest"<br>  },<br>  "centos83-gen2": {<br>    "offer": "CentOS",<br>    "publisher": "OpenLogic",<br>    "sku": "8_3-gen2",<br>    "version": "latest"<br>  },<br>  "centos84-gen2": {<br>    "offer": "CentOS",<br>    "publisher": "OpenLogic",<br>    "sku": "8_4-gen2",<br>    "version": "latest"<br>  },<br>  "ubuntu1604": {<br>    "offer": "UbuntuServer",<br>    "publisher": "Canonical",<br>    "sku": "16.04-LTS",<br>    "version": "latest"<br>  },<br>  "ubuntu1804": {<br>    "offer": "UbuntuServer",<br>    "publisher": "Canonical",<br>    "sku": "18.04-LTS",<br>    "version": "latest"<br>  },<br>  "ubuntu1904": {<br>    "offer": "UbuntuServer",<br>    "publisher": "Canonical",<br>    "sku": "19.04",<br>    "version": "latest"<br>  },<br>  "ubuntu2004": {<br>    "offer": "0001-com-ubuntu-server-focal-daily",<br>    "publisher": "Canonical",<br>    "sku": "20_04-daily-lts",<br>    "version": "latest"<br>  },<br>  "ubuntu2004-gen2": {<br>    "offer": "0001-com-ubuntu-server-focal-daily",<br>    "publisher": "Canonical",<br>    "sku": "20_04-daily-lts-gen2",<br>    "version": "latest"<br>  },<br>  "ubuntu2204-gen2": {<br>    "offer": "0001-com-ubuntu-server-jammy-daily",<br>    "publisher": "Canonical",<br>    "sku": "22_04-daily-lts-gen2",<br>    "version": "latest"<br>  },<br>  "ubuntu2404": {<br>    "offer": "ubuntu-24_04-lts",<br>    "publisher": "Canonical",<br>    "sku": "server",<br>    "version": "latest"<br>  }<br>}</pre> | no |
| <a name="input_linux_distribution_name"></a> [linux\_distribution\_name](#input\_linux\_distribution\_name) | Variable to pick an OS flavour for Linux based VM. Possible values see in <linux\_distribution\_list> | `string` | `"ubuntu2004-gen2"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the resources (Default: eastus). | `string` | `"eastus"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the VMs. Will be used as vm-<NAME><COUNT> to prefix all objectos belonging to the VM. | `any` | n/a | yes |
| <a name="input_nsg_inbound_rules"></a> [nsg\_inbound\_rules](#input\_nsg\_inbound\_rules) | List of network rules to apply to network interface. | `list` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the ressource group this VMs belonging to | `any` | n/a | yes |
| <a name="input_shutdown_time"></a> [shutdown\_time](#input\_shutdown\_time) | Time for auto-shutdown the VMs if auto-shutdown is enabled (Default: 2000, which is 8pm) | `string` | `"2000"` | no |
| <a name="input_ssh_private_keyfile"></a> [ssh\_private\_keyfile](#input\_ssh\_private\_keyfile) | SSH private keyfile for the VMs (Default: ~/.ssh/id\_rsa) | `string` | `"~/.ssh/id_rsa"` | no |
| <a name="input_ssh_public_keyfile"></a> [ssh\_public\_keyfile](#input\_ssh\_public\_keyfile) | SSH public keyfile for the VMs (Default: ~/.ssh/id\_rsa.pub) | `string` | `"~/.ssh/id_rsa.pub"` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | ID of the subnet this VMs are conected to | `any` | n/a | yes |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone for the auto-shutdown time | `string` | `"Central European Standard Time"` | no |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | Adminuser of the VMs (Default: adminuser) | `string` | `"adminuser"` | no |
| <a name="input_vmsize_list"></a> [vmsize\_list](#input\_vmsize\_list) | Pre-defined Azure Linux VM sizes list | <pre>map(object({<br>    size = string<br>  }))</pre> | <pre>{<br>  "high_1c_2m": {<br>    "size": "Standard_F1s"<br>  },<br>  "high_2c_4m": {<br>    "size": "Standard_D2pls_v5"<br>  },<br>  "high_2c_8m": {<br>    "size": "Standard_D2ps_v5"<br>  },<br>  "high_4c_16m": {<br>    "size": "Standard_D4ps_v5"<br>  },<br>  "low_1c_1m": {<br>    "size": "Standard_B1s"<br>  },<br>  "low_1c_2m": {<br>    "size": "Standard_B1ms"<br>  },<br>  "low_2c_4m": {<br>    "size": "Standard_B2s"<br>  },<br>  "low_2c_8m": {<br>    "size": "Standard_B2ms"<br>  }<br>}</pre> | no |
| <a name="input_vmsize_name"></a> [vmsize\_name](#input\_vmsize\_name) | Variable to pick an VMsize. Possible values see in <vmsize\_list> | `string` | `"low_2c_4m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_linux_virtual_machine_ids"></a> [linux\_virtual\_machine\_ids](#output\_linux\_virtual\_machine\_ids) | The resource id's of all Linux Virtual Machine. |
| <a name="output_linux_vm_private_ips"></a> [linux\_vm\_private\_ips](#output\_linux\_vm\_private\_ips) | Public IP's map for the all Virtual Machines |
| <a name="output_linux_vm_public_ips"></a> [linux\_vm\_public\_ips](#output\_linux\_vm\_public\_ips) | Public IP's map for the all Virtual Machines |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | DNS Name of the public IPs |
| <a name="output_vm_details"></a> [vm\_details](#output\_vm\_details) | Detailed information about all VMs |
<!-- END_TF_DOCS -->