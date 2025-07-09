# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name_prefix = "alb-sg"
  description = "Security group for the ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Application Load Balancer (ALB)
resource "aws_lb" "application_load_balancer" {
  name               = var.alb_name
  internal           = var.alb_internal
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.alb_subnets
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
  idle_timeout = var.alb_idle_timeout_seconds

  tags = var.alb_tags
}

# HTTP Listener for the ALB
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  # Default fixed response
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_target_group.arn
  }

  depends_on = [
    aws_lb.application_load_balancer,
    aws_lb_target_group.jenkins_target_group
  ]
}

# Target Group for Jenkins
resource "aws_lb_target_group" "jenkins_target_group" {
  name     = "jenkins-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  

  tags = {
    Name = "jenkins-target-group"
  }
   
  
}

# Attaching Jenkins EC2 instance to the target group
resource "aws_lb_target_group_attachment" "jenkins_target_group_attachment" {
  target_group_arn = aws_lb_target_group.jenkins_target_group.arn
  target_id        = var.instance_id
  port             = 8080

  depends_on = [aws_lb_target_group.jenkins_target_group]
}

# Listener Rule for Jenkins Path-Based Routing
resource "aws_lb_listener_rule" "jenkins_listener_rule" {
  listener_arn = aws_lb_listener.http_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/jenkins*"]  # Route traffic with '/jenkins' path to Jenkins target group
    }
  }

  priority = 100  # Ensure a unique priority

  depends_on = [aws_lb_listener.http_listener]
}


