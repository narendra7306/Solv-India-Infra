output "security_group_id" {
  description = "The security group ID"
  value       = aws_security_group.alb_sg.id  # Adjust to match the resource name
}
