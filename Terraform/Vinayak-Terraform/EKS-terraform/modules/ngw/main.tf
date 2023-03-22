resource "aws_nat_gateway" "vpc_ngw" {
  allocation_id = var.eip_nat_id
  subnet_id     = var.subnet_public_1a_id
  tags = {
    "Name" = "${var.project_name}-ngw"
  }
}