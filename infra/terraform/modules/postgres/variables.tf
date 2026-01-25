variable "instance_name" {
  default = "postgres-instance"
}
variable "region" {
  default = "europe-west1"
}
variable "tier" {
  default = "db-f1-micro"
}

variable "db_name" {
  default = "app_db"
}
variable "db_user" {
  default = "app_user"
}
variable "db_password" {
  sensitive = true
}
