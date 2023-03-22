#OIDC Provider
data "tls_certificate" "eks_cluster" {
  url = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer
}
resource "aws_iam_openid_connect_provider" "eks_cluster_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_cluster.certificates.0.sha1_fingerprint]
  url             = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer
}

//------------------------------------------------------------------------------------------
## Enabling IAM Roles for Service Accounts  for aws-node pod
# data "aws_iam_policy_document" "eks_cluster_alb_iam_role_policy" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]
#     effect  = "Allow"

#     condition {
#       test     = "StringEquals"
#       variable = "${replace(aws_iam_openid_connect_provider.eks_cluster_oidc.url, "https://", "")}:aud"
#       values   = ["sts.amazonaws.com"]
#     }
#     condition {
#       test     = "StringEquals"
#       variable = "${replace(aws_iam_openid_connect_provider.eks_cluster_oidc.url, "https://", "")}:sub"
#       values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
#     }

#     principals {
#       identifiers = [aws_iam_openid_connect_provider.eks_cluster_oidc.arn]
#       type        = "Federated"
#     }
#   }
# }
//------------------------------------------------------------------------------------------
#ALB Controller Role
# resource "aws_iam_role" "eks_alb_controller_role" {
#   name               = "${var.project_name}-AmazonEKSLoadBalancerControllerRole"
#   assume_role_policy = data.aws_iam_policy_document.eks_cluster_alb_iam_role_policy.json
#   tags = {
#     "Name" = "${var.project_name}-AmazonEKSLoadBalancerControllerRole"
#   }
# }

# resource "aws_iam_role_policy_attachment" "attach_alb_policy" {
#   role       = aws_iam_role.eks_alb_controller_role.name
#   policy_arn = var.attach_alb_policy_arn
# }