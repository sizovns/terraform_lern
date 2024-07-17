provider "aws" {
  region = "eu-north-1"
}

data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "nikita-s-terraform-state"
    key    = "lesson/24/globalvas/terraform.tfstate"
    region = "eu-north-1"
  }

}

terraform {
  backend "s3" {
    bucket = "nikita-s-terraform-state"
    key    = "lesson/24/stack1/terraform.tfstate"
    region = "eu-north-1"
  }
}

locals {
  company_name = data.terraform_remote_state.global.outputs.company_name
  common_tags  = data.terraform_remote_state.global.outputs.tags
  owner        = data.terraform_remote_state.global.outputs.owner
}

resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name    = "Stack1-VPC1"
    Company = local.company_name
    Owner   = local.owner
  }
}


resource "aws_vpc" "vpc2" {
    cidr_block = "10.0.0.0/16"
    tags = merge(local.common_tags, {
        Name = "Stack1-VPC2"
        Company = local.company_name
    })
}