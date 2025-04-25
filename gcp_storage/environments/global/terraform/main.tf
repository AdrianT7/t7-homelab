terraform {
  backend "gcs" {
    bucket = "t7_gcp_tf_bucket"
    prefix = "global/gcp_storage"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.32.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
}

module gcp_storage_bucket {
  source = "../../../modules/gcp_bucket"

  project                     = var.project_id
  location                    = var.region
  bucket_name                 = "t7_gcp_storage"
  storage_class               = "STANDARD"
  public_access_prevention    = "enforced"
  force_destroy               = false
  uniform_bucket_level_access = true
  versioning                  = { enabled = true }
  lifecycle_rules = [
    {
      action = {
        type               = "Delete"
      },
      condition = {
        age                = "30"
        num_newer_versions = 1
      }
    }
  ]
}