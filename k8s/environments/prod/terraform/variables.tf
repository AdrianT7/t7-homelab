variable proxmox_api_url          { type = string }
variable proxmox_api_token_id     { type = string }
variable proxmox_tls_insecure     { type = bool }
variable proxmox_api_token_secret { 
  type      = string
  sensitive = true
}