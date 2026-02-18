resource "google_artifact_registry_repository" "repo" {
  project       = var.project_id
  location      = var.region
  repository_id = var.repository_name
  description   = "Docker repository"
  format        = "DOCKER"
}
