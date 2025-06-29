terraform {
   backend "gcs" {
    bucket = "t7_gcp_tf_bucket"
    prefix = "mgmt/docker"
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

module "docker_01_instance" {
  source        = "../../../../terraform/modules/proxmox_vm"
  providers     = { proxmox = proxmox }

  instance_name = "docker-01"
  target_node   = "proxmox"
  template_name = "debian-12-t7-template"
  sockets       = "1"
  cores         = "2"
  memory        = "512"
  disk_size     = "16G"
  storage       = "external-storage"
}