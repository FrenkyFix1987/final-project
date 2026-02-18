terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }
}


resource "kubernetes_namespace" "prod" {
  metadata {
    name = "prod"
  }
}

resource "kubernetes_service_account" "backend" {
  metadata {
    name      = "backend-sa"
    namespace = kubernetes_namespace.prod.metadata[0].name
    annotations = {
      "iam.gke.io/gcp-service-account" = var.gsa_email
    }
  }
}
