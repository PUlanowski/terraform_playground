variable "network_name" {
  description = "Name of the VPC network"
}

variable "subnetwork_name" {
  description = "Name of the subnetwork"
}

variable "ip_cidr_range" {
  description = "CIDR range for the subnetwork"
}

variable "region" {
  description = "GCP region"
}
