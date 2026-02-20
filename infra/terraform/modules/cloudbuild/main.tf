resource "google_cloudbuildv2_connection" "github" {
  provider = google-beta
  name     = "CloudBuildDeploy"
  location = var.region
  project  = var.project_id
  github_config {
    app_installation_id = var.installation_id

    authorizer_credential {
      oauth_token_secret_version = var.cloudbuild_tocken
    }
  }
}

resource "google_cloudbuildv2_repository" "repo" {
  name              = var.repository_name
  parent_connection = google_cloudbuildv2_connection.github.id
  remote_uri        = "https://github.com/${var.repository_owner}/${var.repository_name}.git"
}

resource "google_cloudbuild_trigger" "app_trigger" {
  name     = "frontend-backend-trigger"
  location = var.region
  project  = var.project_id
  filename = "cloudbuild.yaml"

  service_account = var.cloudbuild_sa

  repository_event_config {
    repository = google_cloudbuildv2_repository.repo.id

    push {
      branch = var.branch_regex
    }
  }

  substitutions = {
    _REGION     = var.region
    _REPO_NAME  = var.repo_name
  }
}
