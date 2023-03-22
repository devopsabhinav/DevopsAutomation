resource "aws_eip" "eip_nat" {
  vpc = true
  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}