provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = {
      Owner     = var.env == "prod" ? var.prod_owner : var.nonprod_owner
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 17"
      Env       = var.env
    }
  }
}

variable "env" {
  # default = "prod"
  # default = "dev"
  default = "staging"
}

variable "prod_owner" {
  default = "Nikita S"
}

variable "nonprod_owner" {
  default = "SomeOne E"
}

variable "ec2_size" {
  default = {
    "prod"    = "t3.large"
    "staging" = "t3.medium"
    "dev"     = "t3.micro"
  }
}

variable "allow_port_list" {
  default = {
    "prod"    = ["80", "443"]
    "dev"     = ["80", "443", "8080", "22"]
    "staging" = ["80", "443", "8080"]
  }
}

resource "aws_instance" "my_server" {
  ami = data.aws_ami.latest_aws_linux.id
  # instance_type = var.env == "prod" ? "t3.medium" : "t3.micro"
  instance_type = var.env == "prod" ? var.ec2_size["staging"] : var.ec2_size["dev"]
  tags = {
    "Name" = "${var.env}-server"
  }
}


resource "aws_instance" "my_dev_bastion" {
  count         = var.env == "dev" ? 1 : 0
  ami           = data.aws_ami.latest_aws_linux.id
  instance_type = "t3.micro"
  tags = {
    "Name" = "Bastion Server for Dev"
  }
}


resource "aws_instance" "my_server2" {
  ami           = data.aws_ami.latest_aws_linux.id
  instance_type = lookup(var.ec2_size, var.env)
  tags = {
    "Name" = "${lookup(var.ec2_size, var.env)}-${var.env}-server"
  }
}


resource "aws_security_group" "server" {
  name   = "Dinamic Security Group"
  vpc_id = aws_default_vpc.default.id

  tags = {
    Name    = "SG for WebServer"
    Owner   = "Nikita"
    Project = "Terraform Lesson 5"
  }

  dynamic "ingress" {
    for_each = lookup(var.allow_port_list, var.env)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
