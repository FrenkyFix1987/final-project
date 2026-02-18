resource "google_service_account" "app_sa" {
  account_id   = "fastapi-sa"
  display_name = "App Service Account"
}

resource "google_project_iam_member" "sql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.app_sa.email}"
}

resource "google_project_iam_member" "sql_instance_user" {
  project = var.project_id
  role    = "roles/cloudsql.instanceUser"
  member  = "serviceAccount:${google_service_account.app_sa.email}"
}

resource "google_project_iam_member" "storage_admin" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.app_sa.email}"
}

# Связываем GSA с KSA через Workload Identity
resource "google_service_account_iam_member" "workload_identity_binding" {
  service_account_id = google_service_account.app_sa.name
  role               = "roles/iam.workloadIdentityUser"

  # Формат: serviceAccount:PROJECT_ID.svc.id.goog[NAMESPACE/KSA_NAME]
  member = "serviceAccount:${var.project_id}.svc.id.goog[prod/backend-sa]"
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_iam_member" "artifact_registry_reader_nodes" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}
