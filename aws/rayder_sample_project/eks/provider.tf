provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host  = module.eks.cluster_name.cluster.endpoint
  token = module.eks.cluster_name.cluster.token
  cluster_ca_certificate = base64decode(
    module.eks.cluster_name.cluster.certificate_authority[0].data
  )
}
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}