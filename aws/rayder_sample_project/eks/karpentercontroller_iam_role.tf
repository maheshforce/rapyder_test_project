resource "aws_iam_role" "karpenter_controller" {
  name = "karpenter-${var.cluster_name}"

  assume_role_policy = aws_iam_policy_document.karpenter_trust.json
}
