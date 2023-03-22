#Create Kube-Proxy Addon
resource "aws_eks_addon" "kube_proxy" {
  cluster_name      = var.aws_eks_cluster_name
  addon_name        = "kube-proxy"
  resolve_conflicts = "OVERWRITE"
}

resource "aws_eks_addon" "coredns" {
  cluster_name      = var.aws_eks_cluster_name
  addon_name        = "coredns"
  resolve_conflicts = "OVERWRITE"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name      = var.aws_eks_cluster_name
  addon_name        = "vpc-cni"
  resolve_conflicts = "OVERWRITE"
  addon_version     = "v1.12.0-eksbuild.2"
}

resource "aws_eks_addon" "ebs-cni" {
  cluster_name      = var.aws_eks_cluster_name
  addon_name        = "aws-ebs-csi-driver"
  resolve_conflicts = "OVERWRITE"
  #if not assign the role then it will take inherit from node value as a default value
  #service_account_role_arn = 
}