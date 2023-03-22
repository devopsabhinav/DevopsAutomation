variable "aws_vpc_id" {
  type    = string
  default = null
}
variable "project_name" {
  type = string
  #default = "null"
}
variable "igw_id" {
  type        = string
  default     = "test"
  description = "Internet Gateway ID"
}
variable "ngw_id" {
  type    = string
  default = "test"
}

#Public Subnet IDs
variable "subnet_public_1a_id" {
  type    = string
  default = "test"
}
variable "subnet_public_1b_id" {
  type    = string
  default = "test"
}
variable "subnet_public_1c_id" {
  type    = string
  default = "test"
}

#Private Subnet IDs
variable "subnet_private_1a_id" {
  type    = string
  default = null
}
variable "subnet_private_1b_id" {
  type    = string
  default = null
}
variable "subnet_private_1c_id" {
  type    = string
  default = null
}

# #CIDR Blocks of Public/Private Subnets
# #Public
# variable "cidr_block_public_1a" {
#   type    = string
#   default = "10.0.0.0/24"
# }

# variable "cidr_block_public_1b" {
#   type    = string
#   default = "10.0.1.0/24"
# }

# variable "cidr_block_public_1c" {
#   type    = string
#   default = "10.0.2.0/24"
# }