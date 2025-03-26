terraform {
  backend "s3" {
    bucket         = "mahesh7893" # S3 bucket name
    key            = "vpc/terraform.tfstate" # State file path within the bucket
    region         = "us-east-1"                 # Bucket region
    encrypt        = true                        # Encrypt the
  }
}