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
