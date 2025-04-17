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
  record_name = "seelam-dev.store"
  alb_name    = "jenkins-alb" # Replace with your actual ALB name
}








