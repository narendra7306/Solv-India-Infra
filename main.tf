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
  source = "./modules/vpc"
  public_subnet_cidrs  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnet_cidrs = ["192.168.10.0/24", "192.168.11.0/24"]  
}


/* module "demo-eks" {
  source = "./modules/eks"
  vpc_id = module.demo-vpc.vpc_id
  subnet_ids = [
    module.demo-vpc.public_subnet_1_id,  
    module.demo-vpc.public_subnet_2_id  
  ]
  depends_on = [module.demo-vpc]
}


module "ec2-server" {
  source = "./modules/ec2"
  vpc_id = module.demo-vpc.vpc_id
  subnet_id = module.demo-vpc.public_subnet_1_id
} */












 


