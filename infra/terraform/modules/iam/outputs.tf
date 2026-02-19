output "sa_email" {
  value = google_service_account.app_sa.email
}

output "cloud_build_sa" {
  value = google_service_account.cloudbuild_sa.id
}