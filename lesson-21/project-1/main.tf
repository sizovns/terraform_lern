
provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = {
      Owner     = "Nikita S"
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 20"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "nikita-s-terraform-state"
    key    = "lesson/21/module/terraform.tfstate"
    region = "eu-north-1"
  }
}

# get module from local source
module "vpc_dev" {
  source               = "../modules/aws_network"
  env                  = "dev"
  vpc_cidr             = "10.100.0.0/16"
  public_subnet_cidrs  = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnet_cidrs = []
}

# get modules from remote source (repo)
module "vpc_test" {
  source               = "git@github.com:sizovns/terraform_lern_modules.git//aws_network"
  env                  = "test"
  vpc_cidr             = "10.110.0.0/16"
  public_subnet_cidrs  = ["10.110.1.0/24", "10.110.2.0/24"]
  private_subnet_cidrs = ["10.110.11.0/24", "10.110.22.0/24"]
}

module "vpc_prod" {
  source               = "git@github.com:sizovns/terraform_lern_modules.git//aws_network"
  env                  = "prod"
  vpc_cidr             = "10.10.0.0/16"
  public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  private_subnet_cidrs = ["10.10.11.0/24", "10.10.22.0/24", "10.10.33.0/24"]
}
