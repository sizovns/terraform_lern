provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = {
      Owner     = "Nikita S"
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 19"
    }
  }
}

// use other account with role, or if use other creds access_key, secret_key
provider "aws" {
  region = "us-west-1"
  alias  = "OTHER_ACC"
  assume_role {
    role_arn     = "arn:aws:iam:1234567890:role/RemoteDevops"
    session_name = "TERRAFORM_SESSION_NIKITA_S"
  }
}

provider "aws" {
  region = "eu-central-1"
  alias  = "GER"
  default_tags {
    tags = {
      Owner     = "Nikita S"
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 19"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
  alias  = "CANADA"
  default_tags {
    tags = {
      Owner     = "Nikita S"
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 19"
    }
  }
}

resource "aws_instance" "my_eu_north_server" {
  instance_type = "t3.micro"
  ami           = data.aws_ami.latest_aws_linux.id
  tags = {
    "Name" = "Default Swed Server"
  }
}

resource "aws_instance" "my_eu_central_server" {
  provider      = aws.GER
  instance_type = "t3.micro"
  ami           = data.aws_ami.latest_ger_aws_linux.id
  tags = {
    "Name" = "Default GERMANY Server"
  }
}


resource "aws_instance" "my_ca_central_server" {
  provider      = aws.CANADA
  instance_type = "t3.micro"
  ami           = data.aws_ami.latest_ca_aws_linux.id
  tags = {
    "Name" = "Default CANADA Server"
  }
}
