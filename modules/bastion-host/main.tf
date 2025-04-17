
# Define a security group for the Bastion Host
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-SG"
  description = "Allow inbound SSH and HTTP access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (use specific IP ranges for security)
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
resource "aws_instance" "bastion_host" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]  

  # Define the key pair for SSH access
  key_name = var.key_name


  tags = {
    Name = var.instance_name
  }
}
