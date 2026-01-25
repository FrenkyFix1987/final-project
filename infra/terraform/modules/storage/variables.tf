variable "bucket_name" {
  description = "GCS bucket name"
  type        = string
}

variable "location" {
  description = "Bucket location (region or multi-region)"
  type        = string
}

variable "storage_class" {
  description = "Storage class"
  type        = string
  default     = "STANDARD"
}

variable "versioning" {
  description = "Enable object versioning"
  type        = bool
  default     = false
}

variable "force_destroy" {
  description = "Allow bucket deletion with objects inside"
  type        = bool
  default     = true
}