terraform {
  backend "s3" {
    bucket  = "simba25"               # S3 bucket name
    key     = "eks/terraform.tfstate" # State file path within the bucket
    region  = "us-east-1"             # Bucket region
    encrypt = true
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "simba25"               # S3 bucket name
    key    = "vpc/terraform.tfstate" # State file path within the bucket
    region = "us-east-1"             # Bucket region                     
  }
}