output "instance_id" {
  description = "The instance ID of the Jenkins EC2 instance"
  value       = aws_instance.jenkins_instance[0].id
}
