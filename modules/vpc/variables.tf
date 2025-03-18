# AWS Region
variable "region" {
  description = "The AWS region where the resources will be created"
  type        = string
  default     = "ap-south-1"  # You can change this default value
}

# VPC CIDR block
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"  # Adjust the CIDR block if needed
}


# Public Subnet CIDR block
variable "subnet_cidrs" {
  description = "A list of two subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}


# Availability Zones
variable "availability_zones" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]  # Modify with available AZs
}

# Enable DNS Support for VPC
variable "enable_dns_support" {
  description = "Enable DNS support for the VPC"
  type        = bool
  default     = true
}

# Enable DNS Hostnames for VPC
variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for the VPC"
  type        = bool
  default     = true
}
