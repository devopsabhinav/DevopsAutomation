# output "output_public_subnets_id" {
#   #value = ["${aws_subnet.public_subnet.*.id}"]
#   value = aws_subnet.public_subnets[*].id
# }
# output "output_public_subnets_cidr_blocks" {
#   value = aws_subnet.public_subnets[*].cidr_block
# }
output "output_subnet_public_1a_id" {
  value = aws_subnet.subnet_public_1a.id
}
output "output_subnet_public_1b_id" {
  value = aws_subnet.subnet_public_1b.id
}
output "output_subnet_public_1c_id" {
  value = aws_subnet.subnet_public_1c.id
}

#Private Subnets ID
output "output_subnet_private_1a_id" {
  value = aws_subnet.subnet_private_1a.id
}
output "output_subnet_private_1b_id" {
  value = aws_subnet.subnet_private_1b.id
}
output "output_subnet_private_1c_id" {
  value = aws_subnet.subnet_private_1c.id
}