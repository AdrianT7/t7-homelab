terraform {
   backend "gcs" {
    bucket = "t7_gcp_tf_bucket"
    prefix = "global/t7-dns"
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

module "dns_01_instance" {
  source        = "../../../modules/proxmox_vm"
  providers     = { proxmox = proxmox }

  instance_name = "t7-dns-01"
  target_node   = "proxmox"
  template_name = "ext-debian-12-t7-template"
  sockets       = "1"
  cores         = "1"
  memory        = "512"
  disk_size     = "16G"
  storage       = "external-storage"
}

module "dns_02_instance" {
  source        = "../../../modules/proxmox_vm"
  providers     = { proxmox = proxmox }

  instance_name = "t7-dns-02"
  target_node   = "proxmox"
  template_name = "ext-debian-12-t7-template"
  sockets       = "1"
  cores         = "1"
  memory        = "512"
  disk_size     = "16G"
  storage       = "external-storage"
}