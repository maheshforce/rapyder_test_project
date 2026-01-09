variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "Rapyder"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to use."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "List of public subnet CIDRs."
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway."
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Enable VPN Gateway."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to associate with the resources."
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
    Project     = "Rapyder"
  }
}

variable "private_subnet_tags" {
  description = "Tags for private subnets"
  type        = map(string)
  default     = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}

variable "public_subnet_tags" {
  description = "Tags for public subnets"
  type        = map(string)
  default     = {
    "kubernetes.io/role/elb" = "1"
  }
}

# Control Plane Security Group Variables
variable "control_plane_sg_name" {
  description = "Name of the security group for the EKS control plane"
  type        = string
  default     = "eks-control-plane-sg"
}

variable "control_plane_ingress_cidr_blocks" {
  description = "Allowed CIDR blocks for ingress traffic to the control plane"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "control_plane_egress_cidr_blocks" {
  description = "Allowed CIDR blocks for control plane egress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "kubernetes_api_port" {
  description = "Port for the Kubernetes API server"
  type        = number
  default     = 443
}

# Worker Node Security Group Variables
variable "worker_nodes_sg_name" {
  description = "Name of the security group for EKS worker nodes"
  type        = string
  default     = "eks-worker-nodes-sg"
}



variable "worker_nodes_ingress_cidr_blocks" {
  description = "Allowed CIDR blocks for ingress traffic to worker nodes"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ssh_port" {
  description = "Port for SSH access"
  type        = number
  default     = 22
}

variable "worker_nodes_self_ports" {
  description = "Port range for self-communication within worker nodes"
  type        = object({
    from_port = number
    to_port   = number
    protocol  = string
  })
  default = {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
  }
}

variable "workers_nodes_egress_cidr_blocks" {
  description = "Allowed CIDR blocks for egress traffic from worker nodes"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "region" {
  type = string
  default = "us-east-1"
}
