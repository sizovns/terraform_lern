provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = {
      Owner     = "Nikita S"
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 22"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "nikita-s-terraform-state"
    key    = "lesson/28/terraform.tfstate"
    region = "eu-north-1"
  }
}



resource "aws_instance" "node1" {
  instance_type = "t3.micro"
  ami           = data.aws_ami.latest_aws_linux.id
  tags = {
    "Name" = "Node-1"
  }
}

resource "aws_instance" "node2" {
  instance_type = "t3.micro"
  ami           = data.aws_ami.latest_aws_linux.id
  tags = {
    "Name" = "Node-2"
  }
}

resource "aws_instance" "node3" {
  instance_type = "t3.micro"
  ami           = data.aws_ami.latest_aws_linux.id
  tags = {
    "Name" = "Node-3"
  }
  depends_on = [ aws_instance.node2 ]
}

