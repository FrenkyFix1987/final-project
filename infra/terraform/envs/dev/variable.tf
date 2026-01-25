variable "project_id" {
  type = string
}
variable "region" {
  default = "europe-west1"
}
variable "db_password" {
  sensitive = true
}

variable "zone" {
  default = "europe-west1-b"
  type = string
}

locals {
  common_labels = {
    environment = "dev"
  }
}