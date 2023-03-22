resource "aws_eks_node_group" "aws_eks_node_group" {
  cluster_name    = var.aws_eks_cluster_name
  node_group_name = "${var.project_name}-dev-stage-node-group"
  node_role_arn   = var.eks_node_group_role
  version         = var.aws_eks_cluster_version
  subnet_ids      = ["${var.subnet_private_1a_id}", "${var.subnet_private_1b_id}", "${var.subnet_private_1c_id}"]


  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }
  update_config {
    max_unavailable = var.node_group_max_unavailable
  }
  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]

  }

  #Optional config
  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  disk_size      = 30
  instance_types = ["t3a.medium"]
  #node_group_name_prefix = "Demo_Node_group"
  tags = {
    "Name" = "Demo_Node_group",
    "Type" = "t3a.medium"
  }
  # taint {
  #   key    = "Environment"
  #   value  = "dev-stage"
  #   effect = "NO_SCHEDULE"
  # }
  labels = {
    "Environment" = "dev-stage"
  }
}