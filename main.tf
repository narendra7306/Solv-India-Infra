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

module "solv-vpc" {
  source = "./modules/vpc"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]  
}


module "demo-eks" {
  source = "./modules/eks"
  vpc_id = module.solv-vpc.vpc_id
  subnet_ids = [
    module.solv-vpc.public_subnet_0_id,  
    module.solv-vpc.public_subnet_1_id  
  ]
  depends_on = [module.solv-vpc]
}


/* module "ec2-server" {
  source = "./modules/ec2"
  vpc_id = module.demo-vpc.vpc_id
  subnet_id = module.demo-vpc.public_subnet_1_id
}
 */











 


