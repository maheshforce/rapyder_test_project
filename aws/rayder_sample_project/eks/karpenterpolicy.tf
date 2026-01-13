data "aws_iam_policy_document" "karpenter_assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [module.eks.cluster_oidc_issuer_arn]  # OIDC provider ARN from EKS module
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:karpenter:karpenter"]
    }
  }
}

resource "aws_iam_role" "karpenter" {
  name               = "karpenter-role"
  assume_role_policy = data.aws_iam_policy_document.karpenter_assume_role.json
}

resource "aws_iam_policy" "karpenter" {
  name        = "karpenter-policy"
  description = "IAM policy for Karpenter to manage EC2 instances"
  policy      = file("${path.module}/karpenter-policy.json")  # We’ll create this JSON
}

resource "aws_iam_role_policy_attachment" "karpenter_attach" {
  role       = aws_iam_role.karpenter.name
  policy_arn = aws_iam_policy.karpenter.arn
}
