# String variable
variable "instance_type" {
  description = "A simple string variable"
  type        = string
  default     = "t2.micro"
}

# Float variable
variable "instance_count" {
  description = "A float variable"
  type        = number
  default     = 1
}

# Array variable
variable "key_name" {
  description = "An array of strings"
  type        = string
  default     = "dev-key"
}

variable "ami_id" {
  description = "An array of strings"
  type        = any
  default     = "ami-00bb6a80f01f03502"
}


variable "vpc_id" {
  description = "The VPC ID where the EC2 instance will be created"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the EC2 instance will be created"
  type        = string
}


variable "instance_name" {
  description = "name for the instance"
  type        = string
  default     = "bastion-host"
}




