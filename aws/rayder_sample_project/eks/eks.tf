data "aws_iam_policy" "ssm_managed" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
data "aws_iam_policy" "ssm_managed_READONLY" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

data "aws_iam_policy" "ssm_ec2" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

data "aws_iam_policy" "ssm_full" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}



module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.34.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  enable_irsa = true

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  enable_cluster_creator_admin_permissions = true

  create_iam_role              = true
  create_cluster_security_group = true
  create_node_iam_role         = true
  create_node_security_group   = true

  cluster_security_group_tags = {
    "karpenter.sh/discovery/${var.cluster_name}" = var.cluster_name
    "Environment" = "dev"
  }

  node_security_group_tags = {
    "karpenter.sh/discovery/${var.cluster_name}" = var.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}"  = "owned"
  }

  cluster_addons = {
    coredns = { resolve_conflicts = "OVERWRITE" }
    kube-proxy = {}
    vpc-cni = { resolve_conflicts = "OVERWRITE" }
  }

  eks_managed_node_groups = {

    app = {
      instance_types = ["t3.micro"]
      min_size       = 2
      max_size       = 3
      desired_size   = 2
      labels = { role = "app" }

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = 8
            volume_type = "gp3"
          }
        }
      }

      # Attach SSM Managed Policy here
      additional_iam_policies = [
        data.aws_iam_policy.ssm_managed.arn,
        data.aws_iam_policy.ssm_managed_READONLY.arn,
        data.aws_iam_policy.ssm_ec2.arn,
        data.aws_iam_policy.ssm_full.arn
      ]
    },
    system = {
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 3
      desired_size   = 1
      labels = { role = "system" }

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = 8
            volume_type = "gp3"
          }
        }
      }

      # Attach SSM Managed Policy here
      additional_iam_policies = [
        data.aws_iam_policy.ssm_managed.arn,
        data.aws_iam_policy.ssm_managed_READONLY.arn,
        data.aws_iam_policy.ssm_ec2.arn,
        data.aws_iam_policy.ssm_full.arn
      ]
    }
  }

  tags = var.tags
}
