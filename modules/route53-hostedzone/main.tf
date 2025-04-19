# Create a public hosted zone
resource "aws_route53_zone" "main" {
  name = var.domain_name
}

# Assuming you already have an ALB; here's a reference
data "aws_lb" "jenkins_server_alb" {
  name = "jenkins-alb"      # Replace with actual ALB name
}

# Create an A record (alias) pointing to the ALB
resource "aws_route53_record" "alb_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.record_name
  type    = "A"

  alias {
    name                   = data.aws_lb.jenkins_server_alb.dns_name
    zone_id                = data.aws_lb.jenkins_server_alb.zone_id
    evaluate_target_health = true
  }
}
