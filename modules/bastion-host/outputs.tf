output "instance_id" {
  description = "The instance ID of the Jenkins EC2 instance"
  value       = aws_instance.bastion_host[0].id
}

output "bastion_sg" {
  description = "security group of bastion host"
  value = aws_security_group.bastion_sg.id
}
