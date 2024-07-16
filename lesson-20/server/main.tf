provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = {
      Owner     = "Nikita S"
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 20"
      Env       = var.env
    }
  }
}

terraform {
  backend "s3" {
    bucket = "nikita-s-terraform-state"
    key    = "dev/server/terraform.tfstate"
    region = "eu-north-1"
  }
}


resource "aws_security_group" "webserver" {
  name        = "${var.env}-sg"
  description = "Dinamic Security Group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cider]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "webserver" {
  ami                    = data.aws_ami.latest_aws_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  subnet_id              = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
  user_data              = filebase64("user_data.sh")

  tags = {
    "Name" = "${var.env}-WebServer"
  }
}
