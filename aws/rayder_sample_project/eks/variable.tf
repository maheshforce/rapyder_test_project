# var.tf
# variable "vpc_id" {
#   description = "VPC ID where the EKS cluster will be deployed."
#   type        = string
# }

# variable "private_subnets" {
#   description = "List of private subnets for the EKS cluster."
#   type        = list(string)
# }

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "rapyder-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.30"
}

variable "tags" {
  description = "Tags to be applied to AWS resources."
  type        = map(string)
  default = {
    Environment = "Dev"
    Project     = "EKS-Self-Managed"
  }
}

variable "iam_role_arn" {
  description = "IAM Role ARN for the EKS cluster."
  type        = string
}

variable "cluster_security_group_id" {
  description = "Security Group ID for the EKS cluster."
  type        = string
}

variable "node_security_group_id" {
  description = "Security Group ID for the node group."
  type        = string
}

variable "iam_instance_profile_arn" {
  description = "IAM Instance Profile ARN for worker nodes."
  type        = string
}
