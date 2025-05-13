variable "vpc_id" {
  description = "VPC ID where RDS will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to PostgreSQL"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "db_identifier" {
  default = "my-postgres-db"
}

variable "engine_version" {
  default = "17.4"
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "storage" {
  default = 20
}

variable "db_name" {
  default = "mydb"
}

variable "db_user" {
  default = "myadminuser"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "publicly_accessible" {
  default = true
}
