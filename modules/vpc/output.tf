# Outputs
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

# Output the Public Subnet IDs
output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public_subnet[*].id
}


# Output the Private Subnet IDs
output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private_subnet[*].id
}


output "nat_gateway_id" {
  value = aws_nat_gateway.nat-gw.id
}









