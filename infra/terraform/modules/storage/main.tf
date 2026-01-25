resource "google_storage_bucket" "this" {
  name          = var.bucket_name
  location      = var.location
  storage_class = var.storage_class
  force_destroy = var.force_destroy

  uniform_bucket_level_access = true

  versioning {
    enabled = var.versioning
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
}