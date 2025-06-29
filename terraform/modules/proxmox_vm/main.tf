terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
    }
  }
}

resource "proxmox_vm_qemu" "proxmox_vm" {
  name        = var.instance_name
  target_node = var.target_node
  clone       = var.template_name
  full_clone  = true
  vm_state    = "running"
  cpu_type    = "x86-64-v2-AES"
  sockets     = var.sockets
  cores       = var.cores
  memory      = var.memory
  scsihw      = "virtio-scsi-single"
  boot        = "order=scsi0"

  disk {
    slot     = "scsi0"
    format   = "raw"
    size     = var.disk_size
    storage  = var.storage
  }

  network {
    id    = 0
    model = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [ 
      disk[0].size
    ]
  }
}