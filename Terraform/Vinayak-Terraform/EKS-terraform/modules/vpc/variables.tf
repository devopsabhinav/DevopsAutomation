variable "vpc_cidr_block" {
  type = string
  #default = "10.0.0.0/16" //VPC CIDR Block
}
variable "vpc_name" {
  type    = string
  default = "Demo-VPC" //VPC Name
}
variable "project_name" {
  type = string
  #default = "null"
}