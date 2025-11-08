# Proxmox VM Module Example

This example shows how to provision a single Proxmox VM using the module in `..`. It wires in the required connection details, VM sizing, network settings, and demonstrates how to pass SSH credentials and tags.

## Usage

```bash
cd tf-modules/proxmox/proxmox_vm/example
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars with your Proxmox endpoint, credentials, and desired VM parameters
terraform init
terraform plan
terraform apply
```

When you're done, destroy the test VM and clean up state:

```bash
terraform destroy
rm -f terraform.tfstate terraform.tfstate.backup terraform.tfvars
```

> **Note**: This example is intended for local testing only. Never commit the state file or `terraform.tfvars` with credentials.
