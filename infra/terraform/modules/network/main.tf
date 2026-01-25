resource "google_compute_network" "vpc" {
  name                    = "pet-project-vpc"
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  name                     = "pet-project-subnet"
  project                  = var.project_id
  region                   = var.region
  ip_cidr_range            = "10.10.0.0/16"
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}
