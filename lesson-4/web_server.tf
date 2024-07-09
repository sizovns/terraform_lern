provider "aws" {
  region = "eu-north-1"
}

resource "aws_default_vpc" "default" {}

resource "aws_instance" "WebServer" {
  ami                    = "ami-052387465d846f3fc" # Amazon Linux
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver_80.id]

  tags = {
    Name    = "Apache WebServer"
    Owner   = "Nikita"
    Project = "Terraform Lesson 4"
  }
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Nikita",
    l_name = "S",
    names  = ["Lost", "Scrubs", "Lie To Me"]
  })

}


resource "aws_security_group" "webserver_80" {
  name        = "WebServer Security Group"
  description = "My First Security Group"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name    = "Allow 80 to whole internet"
    Owner   = "Nikita"
    Project = "Terraform Lesson 4"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_80_traffic" {
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.webserver_80.id
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_443_traffic" {
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.webserver_80.id
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.webserver_80.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
