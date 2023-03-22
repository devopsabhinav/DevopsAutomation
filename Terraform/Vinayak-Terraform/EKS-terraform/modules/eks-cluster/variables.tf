variable "project_name" {
  type = string
  #default = "demo"
}
variable "eks_iam_role_arn" {
  type    = string
  default = "null"
}

#EKS Version
variable "eks_version" {
  type = string
  #default = "1.24"
}
#Public Subnet IDs
variable "subnet_public_1a_id" {
  type    = string
  default = "null"
}
variable "subnet_public_1b_id" {
  type    = string
  default = "null"
}
variable "subnet_public_1c_id" {
  type    = string
  default = "null"
}

#Private Subnet IDs
variable "subnet_private_1a_id" {
  type    = string
  default = "null"
}
variable "subnet_private_1b_id" {
  type    = string
  default = "null"
}
variable "subnet_private_1c_id" {
  type    = string
  default = "null"
}

#EKS Cluster SG ID
variable "eks_cluster_sg_id" {
  type    = string
  default = "null"
}

# variable "attach_alb_policy_arn" {
#   type    = string
#   default = "null"
# }