variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type        = string
  default     = "https://192.168.40.13:8006/api2/json"
}

variable "proxmox_token_id" {
  description = "Proxmox API token ID"
  type        = string
  sensitive   = true
}

variable "proxmox_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "proxmox_nodes" {
  description = "Proxmox nodes"
  type        = list(string)
  default     = ["pve-z2g5", "pve-z2g3"]
}


variable "template" {
  description = "Proxmox template to clone"
  type        = string
  default     = "jammy-cloudinit"
}

variable "nameserver" {
  description = "Nameserver for cloud-init"
  type        = string
  default     = "192.168.40.77"
}

variable "ciuser" {
  description = "Cloud-init default user"
  type        = string
  default     = "ubuntu"
}

variable "cipassword" {
  description = "Cloud-init default password"
  type        = string
  sensitive   = true
}

# variable "vms" {
#   description = "List of VMs to create"
#   type = list(object({
#     name         = string
#     vmid         = number
#     target_node  = string
#     cores        = number
#     memory       = number
#     ip_cidr      = string
#     gateway      = string
#     disk_size    = string
#     storage      = string
#     bridge       = string
#   }))
# }