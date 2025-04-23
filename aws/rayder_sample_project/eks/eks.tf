locals {
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  tags            = var.tags
}

module "eks" {
  source          = "github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v20.34.0"
  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  vpc_id                   = data.terraform_remote_state.vpc.outputs.vpc_id
  control_plane_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false
  cluster_tags = merge(local.tags, {
    name    = "rapyder"
    created = "terraform"
  })

  enable_cluster_creator_admin_permissions = true
  create_iam_role = false
  iam_role_arn                             = var.iam_role_arn
  create_cluster_security_group            = false
  cluster_security_group_id                = var.cluster_security_group_id
  enable_irsa = false
   

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  self_managed_node_groups = {
    default = {
      name                   = "self-managed-default"
      desired_size           = 1
      min_size               = 1
      max_size               = 1
      instance_type          = "t2.medium"
      subnet_ids             = data.terraform_remote_state.vpc.outputs.private_subnets
      node_security_group_id = var.node_security_group_id
      labels = {
        Environment                       = "test"
        GithubRepo                        = "terraform-aws-eks"
        GithubOrg                         = "terraform-aws-modules"
        "kubernetes.io/role/internal-elb" = "1"
        "Environment"                     = "private"
      }

      bootstrap_extra_args        = "--kubelet-extra-args '--max-pods=10'"
      enable_monitoring           = false
      create_node_iam_role = false
      iam_instance_profile_arn    = var.iam_instance_profile_arn
      create_node_security_group = false

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = 8
            volume_type = "gp3"
          }
        }
      }
    }
  }

  tags = local.tags
}
