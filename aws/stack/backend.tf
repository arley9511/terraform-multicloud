# Config S3 State Terraform

terraform {
    backend "s3" {
        bucket  = ""
        key     = "infrastructure/terraform.tfstate"
        region  = "us-east-2"
        profile = ""
        shared_credentials_file = "~/.aws/credentials"
  }
}
