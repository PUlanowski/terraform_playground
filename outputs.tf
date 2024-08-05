output "web_server_ip" {
  description = "The IP address of the web server"
  value       = module.compute.web_server_ip
}

output "database_connection" {
  description = "The connection string for the database"
  value       = module.database.connection_string
}

output "storage_bucket_url" {
  description = "The URL of the storage bucket"
  value       = module.storage.bucket_url
}
