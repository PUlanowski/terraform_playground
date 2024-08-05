terraform {
  backend "gcs" {
    bucket  = "tf_state"
    prefix  = "terraform/state"            
    region  = "US"                         
  }
}
