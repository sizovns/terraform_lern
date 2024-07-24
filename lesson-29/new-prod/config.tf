provider "aws" {
  region = "eu-north-1"
}

terraform {
  backend "s3" {
    bucket = "nikita-s-terraform-state"
    key    = "lesson/29/new-prod/terraform.tfstate"
    region = "eu-north-1"
  }
}
