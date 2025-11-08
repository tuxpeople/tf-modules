## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.60 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | ~> 0.60 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.cloudinit_wait](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [proxmox_virtual_environment_file.cloud_config](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_file.main](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_file.vendor_config](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_vm.main](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_enabled"></a> [agent\_enabled](#input\_agent\_enabled) | Enable QEMU guest agent (Default: true) | `bool` | `true` | no |
| <a name="input_cloud_init_wait"></a> [cloud\_init\_wait](#input\_cloud\_init\_wait) | Optional configuration to wait for cloud-init completion via local script | <pre>object({<br/>    enabled         = bool<br/>    script_path     = string<br/>    ssh_user        = string<br/>    ssh_private_key = string<br/>    reboot_delay    = number<br/>    timeout         = number<br/>  })</pre> | `null` | no |
| <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type) | CPU type (Default: host) | `string` | `"host"` | no |
| <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id) | Datastore where the VMs should be placed | `string` | `"local-lvm"` | no |
| <a name="input_disks"></a> [disks](#input\_disks) | Optional list of disk definitions (datastore\_id, file\_id, interface, iothread, discard, size). When empty, a single default disk is created. | <pre>list(object({<br/>    datastore_id = string<br/>    file_id      = string<br/>    interface    = string<br/>    iothread     = bool<br/>    discard      = string<br/>    size         = number<br/>  }))</pre> | `[]` | no |
| <a name="input_disksize"></a> [disksize](#input\_disksize) | Disksize in GB | `number` | n/a | yes |
| <a name="input_distro"></a> [distro](#input\_distro) | Operating system distribution (ubuntu, rocky, debian, centos, fedora) | `string` | `"ubuntu"` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | DNS servers | `list(string)` | <pre>[<br/>  "8.8.8.8",<br/>  "8.8.4.4"<br/>]</pre> | no |
| <a name="input_domain"></a> [domain](#input\_domain) | local domain (Defaults to: lab.tdeutsch.ch) | `string` | `"lab.tdeutsch.ch"` | no |
| <a name="input_enable_provisioner"></a> [enable\_provisioner](#input\_enable\_provisioner) | Enable remote-exec provisioner to wait for cloud-init (Default: false) | `bool` | `false` | no |
| <a name="input_enable_vendor_config"></a> [enable\_vendor\_config](#input\_enable\_vendor\_config) | Enable vendor config for distro-specific setup (Default: true) | `bool` | `true` | no |
| <a name="input_external_meta_data_file_ids"></a> [external\_meta\_data\_file\_ids](#input\_external\_meta\_data\_file\_ids) | Optional meta-data file IDs to use instead of rendering new snippets (length must cover instances\_count) | `list(string)` | `[]` | no |
| <a name="input_external_user_data_file_ids"></a> [external\_user\_data\_file\_ids](#input\_external\_user\_data\_file\_ids) | Optional user-data file IDs to use instead of rendering new snippets (length must cover instances\_count) | `list(string)` | `[]` | no |
| <a name="input_external_vendor_data_file_ids"></a> [external\_vendor\_data\_file\_ids](#input\_external\_vendor\_data\_file\_ids) | Optional vendor-data file IDs to use when enable\_vendor\_config is true | `list(string)` | `[]` | no |
| <a name="input_gateway"></a> [gateway](#input\_gateway) | Gateway IP address | `string` | `""` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname of the VM, will be appended with a number depending on how many VMs being created. | `string` | n/a | yes |
| <a name="input_instances_count"></a> [instances\_count](#input\_instances\_count) | How many of those VM instances? (Default: 1) | `number` | `1` | no |
| <a name="input_ip_addresses"></a> [ip\_addresses](#input\_ip\_addresses) | Static IP addresses for the VMs (CIDR notation, e.g., 192.168.1.100/24). Use empty string for DHCP. | `list(string)` | <pre>[<br/>  ""<br/>]</pre> | no |
| <a name="input_iso_file"></a> [iso\_file](#input\_iso\_file) | ISO file ID for VM installation (e.g., 'local:iso/ubuntu-22.04-server-amd64.iso') | `string` | `""` | no |
| <a name="input_mac_address"></a> [mac\_address](#input\_mac\_address) | MAC Addresses for the VMs | `list(string)` | <pre>[<br/>  ""<br/>]</pre> | no |
| <a name="input_network_bridge"></a> [network\_bridge](#input\_network\_bridge) | Network bridge which the VM should be connected to | `string` | `"vmbr0"` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Proxmox node where the VMs should be placed | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Operating system type (Default: l26) | `string` | `"l26"` | no |
| <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id) | Resource pool where the VMs should be placed | `string` | `""` | no |
| <a name="input_snippets_datastore_id"></a> [snippets\_datastore\_id](#input\_snippets\_datastore\_id) | Datastore for cloud-init snippets (must support file storage, defaults to 'local') | `string` | `"local"` | no |
| <a name="input_ssh_private_keyfile"></a> [ssh\_private\_keyfile](#input\_ssh\_private\_keyfile) | SSH private keyfile for connecting to VMs (Default: ~/.ssh/id\_rsa) | `string` | `"~/.ssh/id_rsa"` | no |
| <a name="input_ssh_public_keyfile"></a> [ssh\_public\_keyfile](#input\_ssh\_public\_keyfile) | SSH public keyfile for the VMs (Default: ~/.ssh/id\_rsa.pub) | `string` | `"~/.ssh/id_rsa.pub"` | no |
| <a name="input_startup_down_delay"></a> [startup\_down\_delay](#input\_startup\_down\_delay) | Startup down delay in seconds (Default: 60) | `string` | `"60"` | no |
| <a name="input_startup_order"></a> [startup\_order](#input\_startup\_order) | VM startup order (Default: 3) | `string` | `"3"` | no |
| <a name="input_startup_up_delay"></a> [startup\_up\_delay](#input\_startup\_up\_delay) | Startup up delay in seconds (Default: 60) | `string` | `"60"` | no |
| <a name="input_stop_on_destroy"></a> [stop\_on\_destroy](#input\_stop\_on\_destroy) | Stop VM before destroying (Default: true) | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to attach to the VMs | `list(string)` | `[]` | no |
| <a name="input_template"></a> [template](#input\_template) | Template to clone from (template ID or empty for no template) | `string` | `""` | no |
| <a name="input_template_datastore_id"></a> [template\_datastore\_id](#input\_template\_datastore\_id) | Datastore where the template is stored (defaults to datastore\_id) | `string` | `""` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Supply a special cloud-init file. If empty, the module's default will be used. | `string` | `""` | no |
| <a name="input_vCPU"></a> [vCPU](#input\_vCPU) | How many vCPU cores | `number` | n/a | yes |
| <a name="input_vMEM"></a> [vMEM](#input\_vMEM) | How much vMEM in MB | `number` | n/a | yes |
| <a name="input_vlan_ids"></a> [vlan\_ids](#input\_vlan\_ids) | Optional VLAN IDs per VM (must align with instances\_count when provided) | `list(number)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_VM"></a> [VM](#output\_VM) | VM Names |
| <a name="output_disk"></a> [disk](#output\_disk) | Disk configuration of the deployed VMs |
| <a name="output_instances"></a> [instances](#output\_instances) | Per-instance connection info (name, vm\_id, ipv4) |
| <a name="output_ip"></a> [ip](#output\_ip) | Default IP addresses of the deployed VMs |
| <a name="output_mac_addresses"></a> [mac\_addresses](#output\_mac\_addresses) | MAC addresses of the VMs |
| <a name="output_node_name"></a> [node\_name](#output\_node\_name) | Proxmox node names where VMs are deployed |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | VM IDs in Proxmox |
