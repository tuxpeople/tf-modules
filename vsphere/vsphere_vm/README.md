<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vsphere_virtual_machine.main](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine) | resource |
| [vsphere_compute_cluster.main](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/compute_cluster) | data source |
| [vsphere_datacenter.main](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datacenter) | data source |
| [vsphere_datastore.main](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datastore) | data source |
| [vsphere_network.main](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/network) | data source |
| [vsphere_virtual_machine.template](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/virtual_machine) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Cluster where the VMs should be placed (Defaults to: Homelab) | `string` | `"Homelab"` | no |
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | Datacenter where the VMs should be placed (Defaults to: SKY) | `string` | `"SKY"` | no |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | Datastore where the VMs should be placed (must exist) | `string` | n/a | yes |
| <a name="input_disksize"></a> [disksize](#input\_disksize) | Disksize in GB | `number` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | local domain (Defaults to: lab.tdeutsch.ch) | `string` | `"lab.tdeutsch.ch"` | no |
| <a name="input_eagerly_scrub"></a> [eagerly\_scrub](#input\_eagerly\_scrub) | Eagerly scrub disk (Defaults to: false) | `bool` | `false` | no |
| <a name="input_folder"></a> [folder](#input\_folder) | Folder where the VMs should be placed (must exist) | `string` | n/a | yes |
| <a name="input_guest_id"></a> [guest\_id](#input\_guest\_id) | guest\_id of the VM (Defaults to: ubuntu64Guest) | `string` | `"ubuntu64Guest"` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname of the VM, will be appended with a number depending on how many VMs beeing created. | `string` | n/a | yes |
| <a name="input_instances_count"></a> [instances\_count](#input\_instances\_count) | How many of those VM instances? (Default: 1) | `string` | `"1"` | no |
| <a name="input_network"></a> [network](#input\_network) | Network which the VM should be connected to (must exist) | `string` | n/a | yes |
| <a name="input_redhat_password"></a> [redhat\_password](#input\_redhat\_password) | Password to subscribe a RHEL system to RedHat (used when guest\_id == rhel8\_64Guest) | `string` | `""` | no |
| <a name="input_redhat_username"></a> [redhat\_username](#input\_redhat\_username) | Username to subscribe a RHEL system to RedHat (used when guest\_id == rhel8\_64Guest) | `string` | `""` | no |
| <a name="input_ssh_private_keyfile"></a> [ssh\_private\_keyfile](#input\_ssh\_private\_keyfile) | SSH private keyfile for the VMs (Default: ~/.ssh/id\_rsa) | `string` | `"~/.ssh/id_rsa"` | no |
| <a name="input_ssh_public_keyfile"></a> [ssh\_public\_keyfile](#input\_ssh\_public\_keyfile) | SSH public keyfile for the VMs (Default: ~/.ssh/id\_rsa.pub) | `string` | `"~/.ssh/id_rsa.pub"` | no |
| <a name="input_template"></a> [template](#input\_template) | Which template to clone. (Defaults to: linux-ubuntu-server-22-04-lts) | `string` | `"linux-ubuntu-server-22-04-lts"` | no |
| <a name="input_thin_provisioned"></a> [thin\_provisioned](#input\_thin\_provisioned) | Thinprovision the disk (Defaults to: true) | `bool` | `true` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Supply a special cloud-init file. If empty, the module's default will be used. | `string` | `""` | no |
| <a name="input_vCPU"></a> [vCPU](#input\_vCPU) | How many vCPU | `number` | n/a | yes |
| <a name="input_vMEM"></a> [vMEM](#input\_vMEM) | How many vMEM | `number` | n/a | yes |
| <a name="input_wait_for_guest_net_routable"></a> [wait\_for\_guest\_net\_routable](#input\_wait\_for\_guest\_net\_routable) | Controls whether or not the guest network waiter waits for a routable address. (Defaults to: true) | `bool` | `true` | no |
| <a name="input_wait_for_guest_net_timeout"></a> [wait\_for\_guest\_net\_timeout](#input\_wait\_for\_guest\_net\_timeout) | The amount of time, in minutes, to wait for an available guest IP address on the virtual machine (Defaults to: 5) | `number` | `"5"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_VM"></a> [VM](#output\_VM) | VM Names |
| <a name="output_disk"></a> [disk](#output\_disk) | Disks of the deployed VM |
| <a name="output_guest-ip"></a> [guest-ip](#output\_guest-ip) | all the registered ip address of the VM |
| <a name="output_ip"></a> [ip](#output\_ip) | default ip address of the deployed VM |
| <a name="output_uuid"></a> [uuid](#output\_uuid) | UUID of the VM in vSphere |
<!-- END_TF_DOCS -->