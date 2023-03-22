#Create EKS Cluster Role
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-eksClusterRole"
  #managed_policy_arns = "${data.aws_iam_policy.eks_cluster_policy.arn}"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_role_policy.json
  tags = {
    Name = "${var.project_name}-eksClusterRole"
  }
}
data "aws_iam_policy_document" "eks_cluster_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}
resource "aws_iam_role_policy_attachment" "attach_eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  count      = length(var.eks_cluster_managed_policy_arns)
  policy_arn = "arn:aws:iam::aws:policy/${var.eks_cluster_managed_policy_arns[count.index]}"
}
//--------------------------------------------------------------------------------------------------------
#Create EKS Node Role
resource "aws_iam_role" "eks_node_role" {
  name               = "${var.project_name}-eksNodeGroupRole"
  assume_role_policy = data.aws_iam_policy_document.eks_node_role_policy.json
  tags = {
    Name = "${var.project_name}-eksNodeGroupRole"
  }
}
data "aws_iam_policy_document" "eks_node_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
resource "aws_iam_role_policy_attachment" "attach_eks_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  count      = length(var.eks_node_managed_policy_arns)
  policy_arn = "arn:aws:iam::aws:policy/${var.eks_node_managed_policy_arns[count.index]}"
}
resource "aws_iam_role_policy_attachment" "attach_ebs_driver_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = var.ebs_driver_policy_arn
}
//--------------------------------------------------------------------------------------------------------

