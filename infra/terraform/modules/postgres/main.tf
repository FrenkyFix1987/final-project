resource "google_sql_database_instance" "this" {
  name             = var.instance_name
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier = var.tier

    backup_configuration {
      enabled = false
    }

    ip_configuration {
      ipv4_enabled = true
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "db" {
  name     = var.db_name
  instance = google_sql_database_instance.this.name
}

resource "google_sql_user" "user" {
  name     = var.db_user
  instance = google_sql_database_instance.this.name
  password = var.db_password
}
