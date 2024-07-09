provider "aws" {
  region = "eu-north-1"
}

resource "aws_default_vpc" "default" {}

resource "aws_eip" "webserver_static_ip" {
  instance = aws_instance.WebServer.id
}

resource "aws_instance" "WebServer" {
  ami                    = "ami-052387465d846f3fc" # Amazon Linux
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]

  tags = {
    Name    = "Apache WebServer"
    Owner   = "Nikita"
    Project = "Terraform Lesson 7"
  }

  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Nikita",
    l_name = "Si",
    names  = ["Lost", "Scrubs", "Lie To Me", "Test", "XYZ", "LOOOL"]
  })

  lifecycle {
    create_before_destroy = true
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
    Name    = "Allow 80 to whole internet"
    Owner   = "Nikita"
    Project = "Terraform Lesson 7"
  }
}
