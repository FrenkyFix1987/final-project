output "secret_versions" {
  value = {
    for k, v in data.google_secret_manager_secret_version.meta :
    k => v.name
  }
}

output "secret_values" {
  value = {
    for k, v in data.google_secret_manager_secret_version_access.access :
    k => v.secret_data
  }
  sensitive = true
}
