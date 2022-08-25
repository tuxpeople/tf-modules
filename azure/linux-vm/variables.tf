variable "name" {
  description = "Name for the VMs. Will be used as vm-<NAME><COUNT> to prefix all objectos belonging to the VM."
}
variable "environment" {
  default     = "development"
  description = "Environment of the resources (Default: development)."
}
variable "location" {
  default     = "eastus"
  description = "Location of the resources (Default: eastus)."
}
variable "resource_group_name" {
  description = "Name of the ressource group this VMs belonging to"
}
variable "subnet" {
  description = "ID of the subnet this VMs are conected to"
}
variable "enable_public_ip_address" {
  default     = false
  type        = bool
  description = "Do this VMs need a public IP address (Default: false)"
}
variable "cloud_init_file" {
  default     = ""
  description = "Path to cloud-init file for the VMs (optional)"
}
variable "vm_username" {
  default     = "adminuser"
  description = "Adminuser of the VMs (Default: adminuser)"
}

variable "default_tags_enabled" {
  description = "Option to enable or disable default tags."
  type        = bool
  default     = true
}

variable "extra_tags" {
  description = "Additional tags to associate with your VMs."
  type        = map(string)
  default     = {}
}

variable "ssh_public_keyfile" {
  default     = "~/.ssh/id_rsa.pub"
  description = "SSH public keyfile for the VMs (Default: ~/.ssh/id_rsa.pub)"
}

variable "ssh_private_keyfile" {
  default     = "~/.ssh/id_rsa"
  description = "SSH private keyfile for the VMs (Default: ~/.ssh/id_rsa)"
}

variable "dns_name" {
  default     = ""
  description = "Hostname for the FQDN, needs to be unique for the whole domain and will be appended with a number depending on how many VMs beeing created. (Default: VM name with number and a random suffix)"
}

variable "dns_domain" {
  default     = ""
  description = "Domain part of the FQDN. Will be appended to <dns_name>. (Default: <location>.cloudapp.azure.com)"
}

variable "instances_count" {
  default     = "1"
  description = "How many of those VM instances? (Default: 1)"
}
variable "enable_vm_shutdown" {
  default     = false
  description = "Should auto-shutdown be enabled for this VMs (Default: false)"
}
variable "shutdown_time" {
  default     = "2000"
  description = "Time for auto-shutdown the VMs if auto-shutdown is enabled (Default: 2000, which is 8pm)"
}
variable "timezone" {
  default     = "Central European Standard Time"
  description = "Timezone for the auto-shutdown time"
}

variable "nsg_inbound_rules" {
  description = "List of network rules to apply to network interface."
  default     = []
}

variable "linux_distribution_name" {
  default     = "ubuntu2004-gen2"
  description = "Variable to pick an OS flavour for Linux based VM. Possible values see in <linux_distribution_list>"
}

variable "vmsize_name" {
  default     = "low_2c_4m"
  description = "Variable to pick an VMsize. Possible values see in <vmsize_list>"
}

variable "vmsize_list" {
  description = "Pre-defined Azure Linux VM sizes list"
  type = map(object({
    size = string
  }))

  default = {
    low_1c_1m = {
      size = "Standard_B1s"
    },

    low_1c_2m = {
      size = "Standard_B1ms"
    },

    low_2c_4m = {
      size = "Standard_B2s"
    },

    low_2c_8m = {
      size = "Standard_B2ms"
    },

    high_1c_2m = {
      size = "Standard_F1s"
    },

    high_2c_4m = {
      size = "Standard_D2pls_v5"
    },

    high_2c_8m = {
      size = "Standard_D2ps_v5"
    },

    high_4c_16m = {
      size = "Standard_D4ps_v5"
    },
  }
}

variable "linux_distribution_list" {
  description = "Pre-defined Azure Linux VM images list"
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))

  default = {
    ubuntu1604 = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "16.04-LTS"
      version   = "latest"
    },

    ubuntu1804 = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    },

    ubuntu1904 = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "19.04"
      version   = "latest"
    },

    ubuntu2004 = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal-daily"
      sku       = "20_04-daily-lts"
      version   = "latest"
    },

    ubuntu2004-gen2 = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal-daily"
      sku       = "20_04-daily-lts-gen2"
      version   = "latest"
    },

    centos77 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "7.7"
      version   = "latest"
    },

    centos78-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "7_8-gen2"
      version   = "latest"
    },

    centos79-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "7_9-gen2"
      version   = "latest"
    },

    centos81 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_1"
      version   = "latest"
    },

    centos81-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_1-gen2"
      version   = "latest"
    },

    centos82-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_2-gen2"
      version   = "latest"
    },

    centos83-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_3-gen2"
      version   = "latest"
    },

    centos84-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_4-gen2"
      version   = "latest"
    },
  }
}
