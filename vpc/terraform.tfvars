vpc_name            = "Rapyder-test-vpc"
vpc_cidr            = "10.0.0.0/16"
availability_zones  = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets      = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
enable_nat_gateway  = false
enable_vpn_gateway  = false
private_subnet_tags = {
  "kubernetes.io/role/internal-elb" = "1"
  "Environment"                     = "private"
}

public_subnet_tags = {
  "kubernetes.io/role/elb" = "1"
  "Environment"            = "public"
}

tags = {
  Terraform   = "true"
  Environment = "dev"
}

# Control Plane Security Group
control_plane_ingress_cidr_blocks = ["10.0.0.0/16"]
kubernetes_api_port               = 443

# Worker Nodes Security Group
worker_nodes_ingress_cidr_blocks = ["192.168.0.0/24"]
worker_nodes_self_ports = {
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"
}

workers_nodes_egress_cidr_blocks = ["0.0.0.0/0"]
ssh_port                        = 22