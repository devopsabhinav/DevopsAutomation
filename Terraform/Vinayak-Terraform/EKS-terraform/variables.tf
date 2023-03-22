#Main & Common
variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "project_name" {
  type = string
}

#VPC 
variable "vpc_cidr_block" { type = string }

#EIP

#Subnets
variable "cidr_block_public_1a" { type = string }
variable "cidr_block_public_1b" { type = string }
variable "cidr_block_public_1c" { type = string }
variable "cidr_block_private_1a" { type = string }
variable "cidr_block_private_1b" { type = string }
variable "cidr_block_private_1c" { type = string }
variable "az_1a" { type = string }
variable "az_1b" { type = string }
variable "az_1c" { type = string }

#EKS
variable "eks_version" { type = string }

#Node_Group
variable "node_group_desired_size" { type = string }
variable "node_group_max_size" { type = string }
variable "node_group_min_size" { type = string }
variable "node_group_max_unavailable" { type = string }


