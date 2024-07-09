provider "aws" {
  region = "eu-north-1"
}

resource "aws_default_vpc" "default" {}

resource "aws_instance" "web_server" {
  ami                    = "ami-052387465d846f3fc" # Amazon Linux
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  depends_on             = [aws_instance.db_server, aws_instance.app_server]

  tags = {
    Name    = "WEB Server"
    Owner   = "Nikita"
    Project = "Terraform Lesson 8"
  }

}

resource "aws_instance" "app_server" {
  ami                    = "ami-052387465d846f3fc" # Amazon Linux
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  depends_on             = [aws_instance.db_server]

  tags = {
    Name    = "APP Server"
    Owner   = "Nikita"
    Project = "Terraform Lesson 8"
  }

}

resource "aws_instance" "db_server" {
  ami                    = "ami-052387465d846f3fc" # Amazon Linux
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]

  tags = {
    Name    = "DB Server"
    Owner   = "Nikita"
    Project = "Terraform Lesson 8"
  }

}

resource "aws_security_group" "webserver" {
  name        = "WebServer Security Group"
  description = "My First Security Group"
  vpc_id      = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = ["80", "443"]
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

  tags = {
    Name    = "Allow 80,443 to whole internet"
    Owner   = "Nikita"
    Project = "Terraform Lesson 8"
  }
}
