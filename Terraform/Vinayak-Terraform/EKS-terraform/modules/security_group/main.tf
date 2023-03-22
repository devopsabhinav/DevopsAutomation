resource "aws_security_group" "security_group_eks_cluster" {
  name   = "${var.project_name}-EKS-cluster-SG"
  vpc_id = var.aws_vpc_id
  #vpc_id = "vpc-02b199c604608e1c9"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow Inbound traffic from cluster SG"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "${var.project_name}-EKS-Additional-Cluster-SG"
  }
}