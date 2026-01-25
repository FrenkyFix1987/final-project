output "public_ip" {
  value = google_sql_database_instance.this.public_ip_address
}

output "connection_name" {
  value = google_sql_database_instance.this.connection_name
}
