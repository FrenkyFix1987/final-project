module "postgres" {
  source = "../../modules/postgres"

  instance_name = "dev-postgres"
  region        = var.region
  tier          = "db-f1-micro"

  db_name       = "app_db"
  db_user       = "app_user"
  db_password   = var.db_password
}

module "storage" {
  source = "../../modules/storage"

  bucket_name   = "frankyfix6-dev-app-bucket"
  location      = var.region
  storage_class = "STANDARD"
  versioning    = false
  force_destroy = true
}

module "network" {
  source     = "../../modules/network"
  project_id = var.project_id
  region     = var.region
  labels     = local.common_labels
}
