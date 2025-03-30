# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

#Security Group Outputs
output "control_plane_sg_id" {
  description = "The security group ID of the EKS control plane"
  value       = module.eks_control_plane_sg.security_group_id
}

output "worker_nodes_sg_id" {
  description = "The security group ID of the EKS worker nodes"
  value       = module.eks_worker_nodes_sg.security_group_id
}

output "internet_gateway_id" {
  value = module.vpc.igw_id
}
