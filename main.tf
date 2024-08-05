provider "google" {
  credentials = file("<path-to-your-service-account-key>.json")
  project     = var.project_id
  region      = var.region
}

module "network" {
  source         = "./modules/network"
  network_name   = "my-network"
  subnetwork_name = "my-subnetwork"
  ip_cidr_range  = "10.0.0.0/24"
  region         = var.region
}

module "compute" {
  source        = "./modules/compute"
  network_name  = module.network.network_name
  subnetwork_name = module.network.subnetwork_name
  instance_count = 3
  machine_type = "e2-medium"
  zone         = var.zone
}

module "database" {
  source           = "./modules/database"
  db_instance_name = "my-db-instance"
  db_user          = "my-db-user"
  db_password      = "my-db-password"
  db_name          = "my-database"
  region           = var.region
}

module "storage" {
  source        = "./modules/storage"
  bucket_name   = "my-webapp-storage"
  region        = var.region
}

output "web_server_ip" {
  value = module.compute.web_server_ip
}

output "database_connection" {
  value = module.database.connection_string
}

output "storage_bucket_url" {
  value = module.storage.bucket_url
}
