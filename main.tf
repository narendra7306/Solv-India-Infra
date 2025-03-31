terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.89.0"
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



module "ec2-server" {
  source    = "./modules/ec2"
  vpc_id    = module.demo-vpc.vpc_id
  subnet_id = module.demo-vpc.public_subnet_ids[0]
}


module "jenkins" {
  source    = "./modules/ec2"
  vpc_id    = module.demo-vpc.vpc_id
  subnet_id = module.demo-vpc.private_subnet_ids[1]
  instance_type = "t2.medium"
  instance_name = "jenkins-server"
}


module "alb" {
  source   = "./modules/alb"
  vpc_id   = module.demo-vpc.vpc_id 
  alb_subnets = module.demo-vpc.public_subnet_ids
  instance_id = module.jenkins.instance_id
  alb_sg_id   = module.alb.security_group_id
}












