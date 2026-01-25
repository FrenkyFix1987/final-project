terraform {
  backend "gcs" {
    bucket = "final-project-tf-state-bucket"
    prefix = "dev/postgres"
  }
}
