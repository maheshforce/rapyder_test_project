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


