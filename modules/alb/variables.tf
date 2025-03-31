# VPC ID where ALB and Jenkins EC2 instance are located
variable "vpc_id" {
  description = "The ID of the VPC where the ALB and Jenkins EC2 instance reside"
  type        = string
}

# List of subnet IDs for ALB
variable "alb_subnets" {
  description = "The list of subnets to associate with the ALB"
  type        = list(string)
}

# ALB Name
variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default     = "jenkins-alb"
}

# ALB Internal or Internet-facing
variable "alb_internal" {
  description = "Set to true if the ALB is internal, false if internet-facing"
  type        = bool
  default     = false
}

# Idle timeout for ALB in seconds
variable "alb_idle_timeout_seconds" {
  description = "The idle timeout for the ALB in seconds"
  type        = number
  default     = 60
}

# Tags to associate with the ALB
variable "alb_tags" {
  description = "Tags to assign to the ALB"
  type        = map(string)
  default     = {
    Name = "jenkins-alb"
  }
}

# Security Group for the ALB
variable "alb_sg_id" {
  description = "The security group ID for the ALB"
  type        = string
}

# Jenkins EC2 instance ID (the target)
variable "instance_id" {
  description = "The EC2 instance ID where Jenkins is installed"
  type        = string
}

# Path to be used for health checks
variable "health_check_path" {
  description = "The path for the health check on Jenkins"
  type        = string
  default     = "/login"
}

# Jenkins server port
variable "jenkins_port" {
  description = "The port Jenkins is running on"
  type        = number
  default     = 8080
}

# Health check settings
variable "health_check_interval" {
  description = "Interval for health check in seconds"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout for health check in seconds"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of consecutive health checks successes required before considering the target healthy"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Number of consecutive health check failures required before considering the target unhealthy"
  type        = number
  default     = 3
}

# Jenkins path pattern for routing
variable "jenkins_path_pattern" {
  description = "The path pattern for routing traffic to Jenkins"
  type        = string
  default     = "/jenkins*"
}
