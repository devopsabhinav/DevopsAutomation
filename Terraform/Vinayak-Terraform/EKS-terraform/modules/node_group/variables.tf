variable "project_name" {
  type = string
}
variable "aws_eks_cluster_name" {
  type    = string
  default = "null"
}
variable "aws_eks_cluster_version" {
  type    = string
  default = "null"
}
variable "eks_node_group_role" {
  type    = string
  default = "null"
}

#Privare Subnet IDs
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

# Node Group Varibale
variable "node_group_desired_size" {
  type = string
  #default = "1"
}
variable "node_group_max_size" {
  type = string
  #default = "2"
}
variable "node_group_min_size" {
  type = string
  #default = "1"
}
variable "node_group_max_unavailable" {
  type = string
  #default = "1"
}
