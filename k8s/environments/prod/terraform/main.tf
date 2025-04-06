terraform {
   backend "gcs" {
    bucket = "t7_gcp_tf_bucket"
    prefix = "prod/k8s"
  }
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc8"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure     = var.proxmox_tls_insecure
}

module "k8s_instance" {
  for_each = {
    "k8s-ctrl-plane-01" = {
      target_node   = "proxmox"
      template_name = "k8s-node-template"
      sockets       = "1"
      cores         = "2"
      memory        = "3072"
      disk_size     = "30G"
    },
    "k8s-node-01" = {
      target_node   = "proxmox"
      template_name = "k8s-node-template"
      sockets       = "1"
      cores         = "2"
      memory        = "2048"
      disk_size     = "30G"
    },
    "k8s-node-02" = {
      target_node   = "proxmox"
      template_name = "k8s-node-template"
      sockets       = "1"
      cores         = "2"
      memory        = "2048"
      disk_size     = "30G"
    }
  }

  source        = "../../../modules/proxmox_vm"
  providers     = { proxmox = proxmox }
  instance_name = each.key
  target_node   = each.value.target_node
  template_name = each.value.template_name
  sockets       = each.value.sockets
  cores         = each.value.cores
  memory        = each.value.memory
  disk_size     = each.value.disk_size
  storage       = "external-storage"
}