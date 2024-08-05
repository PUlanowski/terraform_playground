variable "network_name" {
  description = "Name of the VPC network"
}

variable "subnetwork_name" {
  description = "Name of the subnetwork"
}

variable "instance_count" {
  description = "Number of instances in the managed instance group"
}

variable "machine_type" {
  description = "Machine type for compute instances"
}

variable "zone" {
  description = "Zone for GCP resources"
}
