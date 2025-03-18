# Region where the resources will be created
variable "region" {
  description = "The AWS region where the EKS cluster will be created."
  default     = "ap-south-1"
}

# EKS cluster name
variable "cluster_name" {
  description = "The name of the EKS cluster."
  default     = "my-eks-cluster"
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

# Instance type for the worker nodes
variable "node_instance_type" {
  description = "The EC2 instance type for the nodes in the EKS cluster."
  default     = "t3.medium"
}

# Desired capacity for the worker nodes
variable "desired_capacity" {
  description = "The desired number of nodes in the node group."
  default     = 2
}

# Minimum capacity for the worker nodes
variable "min_capacity" {
  description = "The minimum number of nodes in the node group."
  default     = 1
}

# Maximum capacity for the worker nodes
variable "max_capacity" {
  description = "The maximum number of nodes in the node group."
  default     = 3
}

# Kubernetes version for the EKS cluster
variable "eks_version" {
  description = "The Kubernetes version for the EKS cluster."
  default     = "1.29"
}



variable "vpc_id" {
  type        = string
  description = "The VPC ID where the EKS cluster will be created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnet IDs for the EKS cluster"
}


