provider "aws" {
  region = "eu-north-1"
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "webserver" {
  name        = "WebServer Security Group"
  description = "Dinamic Security Group"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name    = "SG for WebServer"
    Owner   = "Nikita"
    Project = "Terraform Lesson 5"
  }

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "3000"]
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
