#Create Public Route Table
resource "aws_route_table" "route_table_subnet_public" {
  vpc_id = var.aws_vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    "Name" = "${var.project_name}-Public-Route-Table"
  }
}

# resource "aws_route_table_association" "route_table_subnet_public" {
#   count          = length(var.subnet_public_cidrs)
#   subnet_id      = ["${var.output_public_subnets_id}"]
#   route_table_id = aws_route_table.route_table_subnet_public.id
# }

resource "aws_route_table_association" "route_table_subnet_public_1a_association" {
  subnet_id      = var.subnet_public_1a_id
  route_table_id = aws_route_table.route_table_subnet_public.id
}
resource "aws_route_table_association" "route_table_subnet_public_1b_association" {
  subnet_id      = var.subnet_public_1b_id
  route_table_id = aws_route_table.route_table_subnet_public.id
}
resource "aws_route_table_association" "route_table_subnet_public_1c_association" {
  subnet_id      = var.subnet_public_1c_id
  route_table_id = aws_route_table.route_table_subnet_public.id
}

#Create Route Table for Private Subnet 1a
resource "aws_route_table" "route_table_subnet_private_1a" {
  vpc_id = var.aws_vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.ngw_id
  }
  tags = {
    "Name" = "${var.project_name}-Private-Route-Table-1a"
  }
}
resource "aws_route_table_association" "route_table_subnet_private_1a_association" {
  subnet_id      = var.subnet_private_1a_id
  route_table_id = aws_route_table.route_table_subnet_private_1a.id
}

#Create Route Table for Private Subnet 1b
resource "aws_route_table" "route_table_subnet_private_1b" {
  vpc_id = var.aws_vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.ngw_id
  }
  tags = {
    "Name" = "${var.project_name}-Private-Route-Table-1b"
  }
}
resource "aws_route_table_association" "route_table_subnet_private_1b_association" {
  subnet_id      = var.subnet_private_1b_id
  route_table_id = aws_route_table.route_table_subnet_private_1b.id
}

#Create Route Table for Private Subnet 1c
resource "aws_route_table" "route_table_subnet_private_1c" {
  vpc_id = var.aws_vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.ngw_id
  }
  tags = {
    "Name" = "${var.project_name}-Private-Route-Table-1c"
  }
}
resource "aws_route_table_association" "route_table_subnet_private_1c_association" {
  subnet_id      = var.subnet_private_1c_id
  route_table_id = aws_route_table.route_table_subnet_private_1c.id
}