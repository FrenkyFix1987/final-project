output "network_id" {
  value = google_compute_network.vpc.id
}

output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}

output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "subnet_name" {
  value = google_compute_subnetwork.subnet.name
}

output "pods_range_name" {
  value = "pods-range"
}

output "services_range_name" {
  value = "services-range"
}

output "vpc_self_link" {
  value = google_compute_network.vpc.self_link
}

output "private_vpc_connection_id" {
  value = google_service_networking_connection.private_vpc_connection.id
}

