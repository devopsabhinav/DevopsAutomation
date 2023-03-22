//Define Public Subnet Variables
variable "cidr_block_public_1a" {
  type = string
  #default = "10.0.0.0/24"
}

variable "cidr_block_public_1b" {
  type = string
  #default = "10.0.1.0/24"
}

variable "cidr_block_public_1c" {
  type = string
  #default = "10.0.2.0/24"
}

//-----------------------------------------------------------------------------

//Define Private Subnet Variables
variable "cidr_block_private_1a" {
  type = string
  #default = "10.0.3.0/24"
}

variable "cidr_block_private_1b" {
  type = string
  #default = "10.0.4.0/24"
}

variable "cidr_block_private_1c" {
  type = string
  #default = "10.0.5.0/24"
}
//-----------------------------------------------------------------------------

variable "az_1a" {
  type = string
  #default = "eu-central-1a"
}
variable "az_1b" {
  type = string
  #default = "eu-central-1b"
}
variable "az_1c" {
  type = string
  #default = "eu-central-1c"
}

//-----------------------------------------------------------------------------

variable "aws_vpc_id" {
  type        = string
  default     = null
  description = "AWS VPC ID"
}
//-----------------------------------------------------------------------------
variable "project_name" {
  type = string
  #default = "test"
}
//-----------------------------------------------------------------------------