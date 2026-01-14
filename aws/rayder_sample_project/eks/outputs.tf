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


output "certificate_authority" {
  value = module.eks.cluster_certificate_authority_data
}


output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}


output "oidc_provider_url" {
  value = module.eks.cluster_oidc_issuer_url
}


