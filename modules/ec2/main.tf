resource "random_id" "bastion_suffix" {
  byte_length = 4
}

resource "random_id" "jenkins_suffix" {
  byte_length = 4
}

# Define a security group for the Bastion Host
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-SG-${random_id.bastion_suffix.hex}"
  description = "Allow inbound SSH and HTTP access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (use specific IP ranges for security)
  }


  # Allow HTTP access on port 80 from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


  resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-SG-${random_id.jenkins_suffix.hex}"
  description = "Security group for Jenkins Server"
  vpc_id      = var.vpc_id


  # Allow SSH access on port 22 from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access on port 8080 from ALB SG
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "jenkins_instance" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  

  # Associate the security group
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  

  # Define the key pair for SSH access
  key_name = var.key_name


  user_data = <<-EOF
  #!/bin/bash
  # Update package index and install Apache2
  sudo apt-get update -y
  sudo apt-get install -y apache2
  sudo systemctl start apache2
  sudo systemctl enable apache2
  EOF



  tags = {
    Name = var.instance_name
  }
}
