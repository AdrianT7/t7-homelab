terraform {
   backend "gcs" {
    bucket = "t7_gcp_tf_bucket"
    prefix = "global/nginx"
  }
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc9"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure     = var.proxmox_tls_insecure
}

module "nginx_01_instance" {
  source        = "../../../../terraform/modules/proxmox_vm"
  providers     = { proxmox = proxmox }

  instance_name = "nginx-01"
  target_node   = "proxmox-02"
  template_name = "proxmox-02-debian-12-t7"
  sockets       = "1"
  cores         = "1"
  memory        = "1024"
  disk_size     = "35G"
  storage       = "local-lvm"
}