resource "google_sql_database_instance" "db" {
  name             = var.instance_name
  database_version = "POSTGRES_15"
  region           = var.region
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_self_link
    }
  }
  depends_on = [
    var.private_vpc_connection_id
  ]
}

resource "google_sql_database" "database" {
  name     = "app_db"
  instance = google_sql_database_instance.db.name
}

resource "google_sql_user" "iam_user" {
  name     = trimsuffix(var.sa_email, ".gserviceaccount.com")
  instance = google_sql_database_instance.db.name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
  # Ensure the DB and flags are settled
  depends_on = [google_sql_database.database]
  database_roles = ["cloudsqlsuperuser"]
}
