# locals {
#   interface_endpoints = [
#     "ec2",
#     "sts",
#     "eks",
#     "ecr.api",
#     "ecr.dkr",
#     "ssm"
#   ]
# }
# resource "aws_security_group" "vpce" {
#   name   = "${var.cluster_name}-vpce-sg"
#   vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

#   ingress {
#     from_port       = 443
#     to_port         = 443
#     protocol        = "tcp"
#     security_groups = [module.eks.node_security_group_id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = var.tags
# }

# resource "aws_vpc_endpoint" "interface" {
#   for_each = toset(local.interface_endpoints)

#   vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
#   service_name        = "com.amazonaws.${var.region}.${each.key}"
#   vpc_endpoint_type   = "Interface"
#   subnet_ids          = data.terraform_remote_state.vpc.outputs.private_subnets
#   security_group_ids  = [aws_security_group.vpce.id]
#   private_dns_enabled = true

#   tags = var.tags
# }

# resource "aws_vpc_endpoint" "s3" {
#   vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
#   service_name      = "com.amazonaws.${var.region}.s3"
#   vpc_endpoint_type = "Gateway"
#   route_table_ids   = data.terraform_remote_state.vpc.outputs.private_route_table_ids


#   tags = var.tags
# }
