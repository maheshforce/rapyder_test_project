module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway

  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  private_subnet_tags = var.private_subnet_tags

  public_subnet_tags = var.public_subnet_tags

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = var.tags
}

resource "aws_route" "attach_existing_private_rt_to_nat" {
  route_table_id         = "rtb-0aaf5e0849a8d5c15"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.vpc.natgw_ids[0]
}
