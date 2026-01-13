resource "aws_iam_policy" "karpenter_controller" {
  name        = "KarpenterControllerPolicy-${var.cluster_name}"
  description = "IAM policy for Karpenter controller"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateLaunchTemplate",
          "ec2:CreateFleet",
          "ec2:RunInstances",
          "ec2:TerminateInstances",
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplates",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeImages",
          "ec2:DescribeSpotPriceHistory",
          "ec2:DescribeTags",
          "ec2:CreateTags",
          "ec2:DeleteLaunchTemplate",
          "ssm:GetParameter",
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
}
