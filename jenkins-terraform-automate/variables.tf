variable "kubernetes_config_context" {
  description = "kubernetes config cluster"
  type    = string
#   default = ""
}

variable "region_name" {
  type    = string
#   default = "us-east-2"
}

variable "vpc_id" {
  type    = string
#   default = ""
}

variable "cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
#   default     = "0.0.0.0/0"
}

variable "subnet_id1" {
  description = "subnet id for mount target 1"
  type    = string
#   default = ""
}

variable "subnet_id2" {
  description = "subnet id for mount target 2"
  type    = string
#   default = ""
}

variable "subnet_id3" {
  description = "subnet id for mount target 3"
  type    = string
#   default = ""
}

