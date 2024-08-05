resource "google_compute_network" "default" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name          = var.subnetwork_name
  network       = google_compute_network.default.id
  ip_cidr_range  = var.ip_cidr_range
  region         = var.region
}

output "network_name" {
  value = google_compute_network.default.name
}

output "subnetwork_name" {
  value = google_compute_subnetwork.default.name
}
