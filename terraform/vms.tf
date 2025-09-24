locals {
  vms = [
    {
      name        = "k3s-master-01"
      vmid        = 110
      target_node = "pve-z2g3"
      cores       = 2
      memory      = 2048
      ip_cidr     = "192.168.40.20/24"
      gateway     = "192.168.40.1"
      disk_size   = "32G"
      storage     = "local-lvm"
      bridge      = "vmbr0"
    },
    {
      name        = "k3s-worker-01"
      vmid        = 111
      target_node = "pve-z2g5"
      cores       = 2
      memory      = 2048
      ip_cidr     = "192.168.40.21/24"
      gateway     = "192.168.40.1"
      disk_size   = "32G"
      storage     = "local-lvm"
      bridge      = "vmbr0"
    },
    {
      name        = "k3s-worker-02"
      vmid        = 112
      target_node = "pve-z2g5"
      cores       = 2
      memory      = 2048
      ip_cidr     = "192.168.40.22/24"
      gateway     = "192.168.40.1"
      disk_size   = "32G"
      storage     = "local-lvm"
      bridge      = "vmbr0"
    }
  ]
}
