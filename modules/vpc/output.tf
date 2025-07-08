# Outputs
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

# Output the Subnet IDs
output "public_subnet_0_id" {
  value = aws_subnet.public_subnet_0.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}




