variable "project_id" {
  type = string
}

variable "secrets" {
  description = "Map of secret names"
  type        = map(string)
}

variable "secret_version" {
  type        = string
}
