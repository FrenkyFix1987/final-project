data "google_secret_manager_secret_version" "meta" {
  for_each = var.secrets
  project  = var.project_id
  secret   = each.value
  version  = var.secret_version
}

data "google_secret_manager_secret_version_access" "access" {
  for_each = var.secrets
  project  = var.project_id
  secret   = each.value
  version  = var.secret_version
}
