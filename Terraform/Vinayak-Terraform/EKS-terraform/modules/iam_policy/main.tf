#create EBS Driver Policy
resource "aws_iam_policy" "ebs_driver_policy" {
  name        = "${var.project_name}-AmazonEKS_EBS_CSI_Driver_Policy"
  path        = "/"
  description = "Policy for EBS Driver Module"
  tags = {
    Name = "${var.project_name}-AmazonEKS_EBS_CSI_Driver_Policy"
  }
  policy = file("${path.module}/ebs_driver_policy.json")
}

#create ALB controller Policy
# resource "aws_iam_policy" "alb_controller_policy" {
#   name        = "${var.project_name}-AWSLoadBalancerControllerIAMPolicy"
#   path        = "/"
#   description = "Policy for ALB Controller"
#   tags = {
#     Name = "${var.project_name}-AWSLoadBalancerControllerIAMPolicy"
#   }
#   policy = file("${path.module}/alb_controllerpolicy.json")
# }

# #Create External DNS policy
# resource "aws_iam_policy" "external_dns_policy" {
#   name        = "${var.project_name}-AllowExternalDNSUpdates"
#   path        = "/"
#   description = "Policy for External DNS"
#   tags = {
#     "Name" = "${var.project_name}-AllowExternalDNSUpdates"
#   }
#   policy = file("${path.module}/external_dns_policy.json")
# }