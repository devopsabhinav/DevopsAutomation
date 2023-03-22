# #Create Public Subnets
resource "aws_subnet" "subnet_public_1a" {
  availability_zone       = var.az_1a
  cidr_block              = var.cidr_block_public_1a
  vpc_id                  = var.aws_vpc_id
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.project_name}-PublicSubnet-1a"
    "kubernetes.io/role/elb" = "1"
  }
}
resource "aws_subnet" "subnet_public_1b" {
  availability_zone       = var.az_1b
  cidr_block              = var.cidr_block_public_1b
  vpc_id                  = var.aws_vpc_id
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.project_name}-PublicSubnet-1b"
    "kubernetes.io/role/elb" = "1"
  }
}
resource "aws_subnet" "subnet_public_1c" {
  availability_zone       = var.az_1c
  cidr_block              = var.cidr_block_public_1c
  vpc_id                  = var.aws_vpc_id
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.project_name}-PublicSubnet-1c"
    "kubernetes.io/role/elb" = "1"
  }
}
#------------------------------------------------------------
#Create Private Subnets
resource "aws_subnet" "subnet_private_1a" {
  availability_zone = var.az_1a
  cidr_block        = var.cidr_block_private_1a
  vpc_id            = var.aws_vpc_id
  tags = {
    "Name" = "${var.project_name}-PrivateSubnet-1a"
    "kubernetes.io/role/internal-elb" = "1"
  }
}
resource "aws_subnet" "subnet_private_1b" {
  availability_zone = var.az_1b
  cidr_block        = var.cidr_block_private_1b
  vpc_id            = var.aws_vpc_id
  tags = {
    "Name" = "${var.project_name}-PrivateSubnet-1b"
    "kubernetes.io/role/internal-elb" = "1"
  }
}
resource "aws_subnet" "subnet_private_1c" {
  availability_zone = var.az_1c
  cidr_block        = var.cidr_block_private_1c
  vpc_id            = var.aws_vpc_id
  tags = {
    "Name" = "${var.project_name}-PrivateSubnet-1c"
    "kubernetes.io/role/internal-elb" = "1"
  }
}  