data "aws_subnet" "example_subnet" {
  id = var.subnet_id  # Replace with your subnet ID
}


# Create the Jenkins security group
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-SG"
  description = "Security group for Jenkins Server"
  vpc_id      = var.vpc_id

  # Allow jenkins port 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.10.0/24", "10.0.11.0/24"]
  }

  #Allow SSH port 22
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["10.0.10.0/24"]
  }


  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Create an EC2 instance for Jenkins
resource "aws_instance" "jenkins_instance" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  # Define the key pair for SSH access
  key_name = var.key_name

  user_data = filebase64("${path.module}/jenkins-server.sh")
  user_data_replace_on_change = true

    

  tags = {
    Name = var.instance_name
  }
}
