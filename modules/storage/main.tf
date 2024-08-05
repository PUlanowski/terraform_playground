resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location       = var.region
  force_destroy  = true
}

resource "google_storage_bucket" "tf_state" {
  name          = "my-terraform-state-bucket"
  location       = "US"
  force_destroy  = true
}

output "bucket_url" {
  value = "gs://${google_storage_bucket.bucket.name}"
}

output "state_bucket_url" {
  value = "gs://${google_storage_bucket.tf_state.name}"
}