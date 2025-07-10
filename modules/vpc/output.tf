output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_0_id" {
  value = aws_subnet.public[0].id
}

output "public_subnet_1_id" {
  value = aws_subnet.public[1].id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}
