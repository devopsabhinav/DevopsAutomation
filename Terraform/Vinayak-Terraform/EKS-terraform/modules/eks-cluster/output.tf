output "output_aws_eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

# output "output_aws_eks_cluster_kubeconfig_ca_data" {
#   value = aws_eks_cluster.eks_cluster.certificate_authority.data
# }

output "output_aws_eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}
output "output_eks_cluster_version" {
  value = aws_eks_cluster.eks_cluster.version
}

output "output_aws_eks_cluster_certificate" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}
output "output_aws_eks_cluster_token" {
  value = data.aws_eks_cluster_auth.eks_cluster.token
}
output "output_aws_eks_cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}

#OIDC ARN
output "output_oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.eks_cluster_oidc.arn
}
# output "output_oidc_provider_issuer" {
#   value = aws_iam_openid_connect_provider.eks_cluster_oidc.issuer
# }
output "output_oidc_provider_url" {
  value = aws_iam_openid_connect_provider.eks_cluster_oidc.url
}
# output "output_eks_alb_role_name" {
#   value = aws_iam_role.eks_alb_controller_role.name
# }