variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "repository_name" {
  type = string
}

variable "repository_owner" {
  type = string
}

variable "branch_regex" {
  type    = string
  default = "^main$"
}

variable "cluster_name" {
  type = string
}

variable "cluster_location" {
  type = string
}

variable "cloudbuild_sa" { 
  type = string
}
