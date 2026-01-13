output "vpc_id" {
  value = data.terraform_remote_state.vpc.outputs.vpc_id
}

output "private_subnets" {
  value = data.terraform_remote_state.vpc.outputs.private_subnets
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

# Output all managed node group names
output "node_group_names" {
  value = module.eks.eks_managed_node_groups
}


output "cluster_ca" {
  value = module.eks.certificate_authority[0].data
}

output "security_groups" {
  value = module.eks.security_groups
}

output "OIDC" {
  value = module.eks.oidc_provider_url
}

