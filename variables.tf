# String variable
variable "instance_type" {
  description = "A simple string variable"
  type        = string
  default     = "t2.micro"
}


variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

