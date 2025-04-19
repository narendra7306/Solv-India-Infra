terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}

module "demo-vpc" {
  source = "./modules/vpc"
  vpc_id = module.demo-vpc.vpc_id
}



module "dev-bastion" {
  source    = "./modules/bastion-host"
  vpc_id    = module.demo-vpc.vpc_id
  subnet_id = module.demo-vpc.public_subnet_ids[0]
}


module "jenkins" {
  source             = "./modules/jenkins-server"
  vpc_id             = module.demo-vpc.vpc_id
  subnet_id          = module.demo-vpc.private_subnet_ids[1]
  instance_type      = "t2.medium"
  instance_name      = "jenkins-server"
  #alb_sg_id          = module.alb.alb_sg_id
  bastion_cidr       = module.dev-bastion.bastion_sg
  subnet_cidrs       = module.demo-vpc.public_subnet_ids[0]
}


/* module "alb" {
  source      = "./modules/alb"
  vpc_id      = module.demo-vpc.vpc_id
  alb_subnets = module.demo-vpc.public_subnet_ids
  instance_id = module.jenkins.instance_id
  alb_sg_id   = module.alb.alb_sg_id
} */



module "route53" {
  source      = "./modules/route53-hostedzone"
  domain_name = "seelam-dev.store"
  record_name = "jenkins.seelam-dev.store"
  alb_name    = "jenkins-alb" # Replace with your actual ALB name
}


resource "aws_lb" "my_alb" {
  name               = "jenkins-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-01962224d0ef5e611"]  # Your actual security group ID
  subnets            = ["subnet-0668ff9e9da0b60d4", "subnet-0534d049f9efe1a26"]  # Your actual subnet IDs
}







