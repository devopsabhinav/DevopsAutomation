resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true" //gives you an internal domain name
  enable_dns_hostnames = "true" //gives you an internal host name
  tags = {
    Name = "${var.project_name}-VPC"
  }
}