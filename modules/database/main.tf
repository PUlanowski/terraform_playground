resource "google_sql_database_instance" "db_instance" {
  name             = var.db_instance_name
  database_version = "POSTGRES_13"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_user" "db_user" {
  name     = var.db_user
  instance = google_sql_database_instance.db_instance.name
  password = var.db_password
}

output "connection_string" {
  value = "postgres://${var.db_user}:${var.db_password}@${google_sql_database_instance.db_instance.public_ip_address[0]}/${var.db_name}"
}
