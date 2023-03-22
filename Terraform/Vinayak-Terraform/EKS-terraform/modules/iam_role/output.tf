output "output_eks_cluster_iam_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "output_eks_node_group_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}
output "output_eks_node_group_role_name" {
  value = aws_iam_role.eks_node_role.name
}