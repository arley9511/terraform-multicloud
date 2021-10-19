# Config S3 State Terraform

terraform {
  backend "gcs" {
    bucket = ""
    prefix = "terraform/state"
  }
}
