terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token_secret
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "vm" {
  for_each    = { for vm in local.vms : vm.name => vm }

  vmid        = each.value.vmid
  name        = each.value.name
  target_node = each.value.target_node
  agent       = 1

  cpu { cores = each.value.cores }
  memory      = each.value.memory

  boot        = "order=scsi0;ide2"
  clone       = var.template
  full_clone  = true

  scsihw      = "virtio-scsi-single"
  vm_state    = "running"
  automatic_reboot = true

  os_type     = "cloud-init"

  ciupgrade   = true
  nameserver  = var.nameserver
  ipconfig0   = "ip=${each.value.ip_cidr},gw=${each.value.gateway}"
  skip_ipv6   = true
  ciuser      = var.ciuser
  cipassword  = var.cipassword

 vga {
    type = "std"
    memory = 16
  }

  serial {
    id   = 0
    type = "socket"
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage    = each.value.storage
          size       = each.value.disk_size
          cache      = "writeback"
          discard    = true
          backup     = true
          iothread   = true
          replicate  = true
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = each.value.storage
        }
      }
    }
  }

  network {
    id     = 0
    bridge = each.value.bridge
    model  = "virtio"
  }
}

output "vm_ips" {
  value = { for name, vm in proxmox_vm_qemu.vm : name => vm.default_ipv4_address }
}

output "vm_ids" {
  value = { for name, vm in proxmox_vm_qemu.vm : name => vm.vmid }
}