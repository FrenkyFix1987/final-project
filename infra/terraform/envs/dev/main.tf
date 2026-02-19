# 1. Enable APIs (Merged into one block)
resource "google_project_service" "apis" {
  for_each = toset([
    "servicenetworking.googleapis.com",
    "sqladmin.googleapis.com",
    "container.googleapis.com"
  ])
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}

# 2. Wait 60s for APIs to activate (Prevents 403 Errors)
resource "time_sleep" "wait_60_seconds" {
  depends_on      = [google_project_service.apis]
  create_duration = "60s"
}

# 3. Network (Waits for APIs)
module "network" {
  source     = "../../modules/network"
  project_id = var.project_id
  region     = var.region
  depends_on = [time_sleep.wait_60_seconds]
}

module "iam" {
  source     = "../../modules/iam"
  project_id = var.project_id
}

module "storage" {
  source      = "../../modules/storage"
  bucket_name = "frankyfix6-prod-storage-unique"
  location    = var.region
}

module "postgres" {
  source        = "../../modules/postgres"
  project_id    = var.project_id
  region        = var.region
  sa_email      = module.iam.sa_email
  instance_name = "prod-db-instance"
  vpc_self_link = module.network.vpc_self_link
  private_vpc_connection_id = module.network.private_vpc_connection_id
  depends_on = [
    module.network 
  ]
}

module "artifact_registry" {
  source          = "../../modules/artifact_registry"
  project_id      = var.project_id
  region          = var.region
  repository_name = "app-repo"
}

module "gke" {
  source = "../../modules/gke"

  project_id  = var.project_id
  region      = var.region
  cluster_name = "prod-cluster"

  network    = module.network.vpc_name
  subnetwork = module.network.subnet_name

  ip_range_pods     = module.network.pods_range_name
  ip_range_services = module.network.services_range_name

  gsa_email = module.iam.sa_email
}

data "google_client_config" "default" {}

provider "kubernetes" {
  alias                  = "gke"
  host                   = module.gke.cluster_endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
}

module "gke-k8s" {
  source = "../../modules/gke-k8s"

  gsa_email = module.iam.sa_email

  providers = {
    kubernetes = kubernetes.gke
  }
  depends_on = [ module.gke ]
}

module "cloudbuild" {
  source = "../../modules/cloudbuild"

  project_id       = var.project_id
  region           = var.region
  repository_name  = "final-project"
  repository_owner = "FrenkyFix1987"
  cloudbuild_sa    = module.iam.cloud_build_sa

  cluster_name     = module.gke.cluster_name
  cluster_location = var.region
}
