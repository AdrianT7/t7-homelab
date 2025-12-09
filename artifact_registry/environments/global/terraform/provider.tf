terraform {
  backend "gcs"{
    bucket = "t7_gcp_tf_bucket"
    prefix = "global/gcp_artifact_registry"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.13.0"
    }
  }
}

provider "google" {
    project = var.project_id
    region  = var.region
}

provider "google" {
  alias   = "impersonated"
  project = var.project_id
  region  = var.region

  impersonate_service_account = var.impersonate_service_account
}