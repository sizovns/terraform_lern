provider "aws" {
  region = "eu-north-1"
}

terraform {
  backend "s3" {
    bucket = "nikita-s-terraform-state"
    key    = "lesson/24/globalvas/terraform.tfstate"
    region = "eu-north-1"
  }
}


output "company_name" {
  value = "SomeCompany"
}

output "owner" {
  value = "Nikita S"
}

output "tags" {
  value = {
    Owner     = "Nikita S"
    CreatedBy = "Terraform"
    Project   = "Terraform Lesson 24"
    Country   = "Sweeden"
  }
}
