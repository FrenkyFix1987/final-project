resource "google_cloudbuildv2_connection" "github" {
  provider = google-beta
  name     = "CloudBuildDeploy"
  location = var.region
  project  = var.project_id
}

resource "google_cloudbuildv2_repository" "repo" {
  name              = var.repository_name
  parent_connection = google_cloudbuildv2_connection.github.id
  remote_uri        = "https://github.com/${var.repository_owner}/${var.repository_name}"
}

resource "google_cloudbuild_trigger" "app_trigger" {
  name     = "${var.repository_name}-trigger"
  location = var.region
  project  = var.project_id

  service_account = var.cloudbuild_sa

  repository_event_config {
    repository = google_cloudbuildv2_repository.repo.id

    push {
      branch = var.branch_regex
    }
  }

  filename = "cloudbuild.yaml"
}
