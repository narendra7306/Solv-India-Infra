# Input values (replace with real IDs)
variable "demo_vpc_id" {
  default = "vpc-030233ff5d809d92e"
}

variable "solv_vpc_id" {
  default = "vpc-07d05a2845621eafb"
}

variable "demo_vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "solv_vpc_cidr" {
  default = "10.0.0.0/16"
}

# Route Table IDs for demo-vpc
variable "demo_public_rt_id" {
  default = "rtb-090eccf5b27c137d2"
}

variable "demo_private_rt_id" {
  default = "rtb-0a54a00f741ad473f"
}

# Route Table IDs for solv-india vpc
variable "solv_public_rt_id" {
  default = "rtb-0ae88c92fbe87304f"
}

variable "solv_private_rt_id" {
  default = "rtb-0a6d671cf0d48b0f9"
}