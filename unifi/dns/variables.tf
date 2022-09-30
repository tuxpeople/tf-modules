variable "serverrecord" {
  description = "Map of server records (Defaults to {}) Eg: {name = \"Mabel\", age = 52}"
  type        = map(any)
  default     = {}
}

variable "addressrecord" {
  description = "Map of address records (Defaults to {}) Eg: {name = \"Mabel\", age = 52}"
  type        = map(any)
  default     = {}
}

variable "hostrecord" {
  description = "Map of host records (Defaults to {}) Eg: {name = \"Mabel\", age = 52}"
  type        = map(any)
  default     = {}
}

variable "cnamerecord" {
  description = "Map of cname records (Defaults to {}) Eg: {name = \"Mabel\", age = 52}"
  type        = map(any)
  default     = {}
}

variable "sshkey" {
  description = "Path to ssh-key (Defaults to ~/.ssh/id_rsa)"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "sshuser" {
  description = "SSH Username (Defaults to root)"
  type        = string
  default     = "root"
}

variable "dnsserver" {
  description = "Host of DNS server (Defaults to 10.20.30.1)"
  type        = string
  default     = "10.20.30.1"
}
