provider "aws" { // My Root Account
  region = "eu-north-1"
  default_tags {
    tags = {
      Owner     = "Nikita S"
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 22"
      Account   = "root"
    }
  }
}

provider "aws" { // My DEV Account
  region = "eu-central-1"
  alias  = "dev"

  # assume_role {
  #   role_arn     = "arn:aws:iam::9753:user/dev_user"
  #   session_name = "TERRAFORM_SESSION_DEV_NIKITA_S"
  # }

  default_tags {
    tags = {
      Owner     = "Nikita S"
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 22"
      Account   = "dev"
    }
  }
}

provider "aws" { // My PROD Account
  region = "ca-central-1"
  alias  = "prod"

  # assume_role {
  #   role_arn     = "arn:aws:iam::9753:user/prod_user"
  #   session_name = "TERRAFORM_SESSION_PROD_NIKITA_S"
  # }

  default_tags {
    tags = {
      Owner     = "Nikita S"
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 22"
      Account   = "prod"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "nikita-s-terraform-state"
    key    = "lesson/22/module/terraform.tfstate"
    region = "eu-north-1"
  }
}

module "servers" {
  source        = "./module/servers"
  instance_type = "t3.micro"
  providers = {
    aws.root = aws
    aws.dev  = aws.dev
    aws.prod = aws.prod
  }
}
