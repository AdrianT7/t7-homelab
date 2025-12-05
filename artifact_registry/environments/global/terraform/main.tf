resource "google_artifact_registry_repository" "t7-docker-repository" {
  provider      = google.impersonated

  location      = "europe-west3"
  repository_id = "t7-docker-repository"
  description   = "docker repository for storing my private docker images"
  format        = "DOCKER"
  mode          = "STANDARD_REPOSITORY"
}