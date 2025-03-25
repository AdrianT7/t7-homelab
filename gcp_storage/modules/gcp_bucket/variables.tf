variable project                     { type = string }
variable bucket_name                 { type = string }
variable location                    { type = string }
variable force_destroy               { type = bool }
variable storage_class               { type = string }
variable uniform_bucket_level_access { 
  type    = bool 
  default = true
}
variable public_access_prevention    { 
  type    = string
  default = "enforced" 
}
variable "lifecycle_rules" { 
  type = list(object({
    action = map(string)
    condition = object({
      age                = number
      matches_prefix     = optional(list(string))
      num_newer_versions = optional(number)
    })
  }))
  default = []
}
variable versioning {
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}