provider "aws" {
  region = "eu-north-1"
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_aws_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "latest_win_2016" {
  owners      = ["801119661308"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}

resource "aws_instance" "my_ubuntu" {
  count         = 1
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
  tags = {
    Name    = "My Ubuntu Server"
    Owner   = "Nikita"
    Project = "Terraform Lesson 10"
  }
}

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}

output "latest_aws_linux_ami_id" {
  value = data.aws_ami.latest_aws_linux.id
}

output "latest_aws_linux_ami_name" {
  value = data.aws_ami.latest_aws_linux.name
}

output "latest_win_2016_ami_id" {
  value = data.aws_ami.latest_win_2016.id
}

output "latest_win_2016_ami_name" {
  value = data.aws_ami.latest_win_2016.name
}

