variable "domain_name" {
  default = "seelam-dev.store"
}

variable "record_name" {
  type        = string
  description = "The record name (e.g. seelam-dev.store or jenkins.seelam-dev.store)"
}

variable "alb_name" {
  type        = string
  description = "Name of the existing ALB"
}
