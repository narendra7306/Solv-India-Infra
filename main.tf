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
  profile                  = "default"
}

module "demo-vpc" {
  source    = "./modules/vpc"
  vpc_id    = module.demo-vpc.vpc_id
}



module "demo-eks" {
  source     = "./modules/eks"
  vpc_id     = module.demo-vpc.vpc_id
  subnet_ids = module.demo-vpc.private_subnet_ids
  depends_on = [module.demo-vpc]
}



/* module "vpc-peer" {
  source   = "./modules/vpc-peering"
} */
















