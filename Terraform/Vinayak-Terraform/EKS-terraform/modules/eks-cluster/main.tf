resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.project_name}-cluster"
  role_arn = var.eks_iam_role_arn
  version  = var.eks_version
  vpc_config {
    subnet_ids              = [var.subnet_private_1a_id, var.subnet_private_1b_id, var.subnet_private_1c_id, var.subnet_public_1a_id, var.subnet_public_1b_id, var.subnet_public_1c_id]
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs = [
      "0.0.0.0/0",
    ]
    security_group_ids = [var.eks_cluster_sg_id]
  }
  tags = {
    Project = var.project_name
  }

}
data "aws_eks_cluster_auth" "eks_cluster" {
  name = aws_eks_cluster.eks_cluster.name
}