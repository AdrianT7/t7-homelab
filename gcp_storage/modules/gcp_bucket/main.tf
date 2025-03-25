resource "google_storage_bucket" "bucket" {
  project                     = var.project
  name                        = var.bucket_name
  location                    = var.location
  force_destroy               = var.force_destroy
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  public_access_prevention    = var.public_access_prevention

  versioning {
    enabled = true
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content  {
      action {
        type               = lifecycle_rule.value.action["type"]
        storage_class      = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                = lookup(lifecycle_rule.value.condition, "age", null)
        matches_prefix     = lookup(lifecycle_rule.value.condition, "matches_prefix", [])
        num_newer_versions = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }
    }
  }
}