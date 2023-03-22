resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = var.aws_vpc_id
  tags = {
    Name = "${var.project_name}-igw"
  }
}