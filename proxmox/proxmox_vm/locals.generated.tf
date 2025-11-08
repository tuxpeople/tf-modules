locals {
  user_data_file_ids   = local.use_external_user_data ? slice(var.external_user_data_file_ids, 0, var.instances_count) : [for f in proxmox_virtual_environment_file.cloud_config : f.id]
  meta_data_file_ids   = local.use_external_meta_data ? slice(var.external_meta_data_file_ids, 0, var.instances_count) : [for f in proxmox_virtual_environment_file.main : f.id]
  vendor_data_file_ids = var.enable_vendor_config ? (local.use_external_vendor_data ? slice(var.external_vendor_data_file_ids, 0, var.instances_count) : [for f in proxmox_virtual_environment_file.vendor_config : f.id]) : []
}
