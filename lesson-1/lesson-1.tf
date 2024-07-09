provider "aws" {
  region = "eu-north-1"
}

resource "aws_default_vpc" "default" {
#   vpc_id = aws_default_vpc.default.id
}

resource "aws_instance" "my_ubuntu" {
  count         = 1
  ami           = "ami-07c8c1b18ca66bb07"
  instance_type = "t3.micro"
  tags = {
    Name    = "My Ubuntu Server"
    Owner   = "Nikita"
    Project = "Terraform Lesson 1"
  }
}

resource "aws_instance" "my_amazon_linux" {
  ami           = "ami-052387465d846f3fc"
  instance_type = "t3.micro"
  tags = {
    Name    = "My Amazon Server"
    Owner   = "Nikita"
    Project = "Terraform Lesson 1"
  }
}
