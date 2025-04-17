# AWS Region
variable "region" {
  description = "The AWS region where the resources will be created"
  type        = string
  default     = "ap-south-1" # You can change this default value
}

# VPC CIDR block
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16" # Adjust the CIDR block if needed
}


# Public Subnet CIDR block
variable "subnet_cidrs" {
  description = "A list of two subnet CIDRs"
  type        = list(string)
  default     = ["192.168.10.0/24", "192.168.11.0/24"]
}


# Private Subnet CIDR block
variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["192.168.8.0/24", "192.168.9.0/24"]
}


# Availability Zones
variable "availability_zones" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
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



variable "vpc_id" {
  description = "The ID of the VPC to create resources in"
  type        = string
}