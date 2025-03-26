module "eks_control_plane_sg" {
  source  = "github.com/terraform-aws-modules/terraform-aws-security-group.git"

  name        = var.control_plane_sg_name
  description = var.control_plane_sg_description
  vpc_id      = module.vpc.default_vpc_id

  ingress_with_cidr_blocks = [
    {
      description = "Allow Kubernetes API access"
      from_port   = var.kubernetes_api_port
      to_port     = var.kubernetes_api_port
      protocol    = "tcp"
      cidr_blocks = element(var.control_plane_ingress_cidr_blocks, 0)

    }
  ]

  egress_with_cidr_blocks = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = element(var.control_plane_egress_cidr_blocks, 0)
    }
  ]
}

module "eks_worker_nodes_sg" {
  source  = "github.com/terraform-aws-modules/terraform-aws-security-group.git"

  name        = var.worker_nodes_sg_name
  description = var.worker_nodes_sg_description
  vpc_id      = module.vpc.default_vpc_id

  ingress_with_self = [
    {
      description = "Allow traffic within the worker nodes"
      from_port   = var.worker_nodes_self_ports.from_port
      to_port     = var.worker_nodes_self_ports.to_port
      protocol    = var.worker_nodes_self_ports.protocol
    }
  ]

  ingress_with_cidr_blocks = [
    {
      description = "Allow SSH access"
      from_port   = var.ssh_port
      to_port     = var.ssh_port
      protocol    = "tcp"
      cidr_blocks = element(var.worker_nodes_ingress_cidr_blocks, 0)
    }
  ]

  egress_with_cidr_blocks = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = element(var.workers_nodes_egress_cidr_blocks, 0)
    }
  ]
}
