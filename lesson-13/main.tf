provider "aws" {
  region = var.region

  default_tags {
    tags = var.common_tags
  }
}

resource "aws_security_group" "my_server_sg" {
  name        = "My Security Group"
  description = "Dinamic Security Group"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "SG for WebServer"
  }

  dynamic "ingress" {
    for_each = var.allow_ports
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

resource "aws_instance" "my_server_ec2" {
  ami                    = data.aws_ami.latest_aws_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_server_sg.id]
  monitoring             = var.detailed_monitoring

  tags = {
    Name = "Server"
  }

}

resource "aws_eip" "my_server_eip" {
  instance = aws_instance.my_server_ec2.id
  tags = merge(var.common_tags, {
    Name = "${var.common_tags["Environment"]} - Static Server IP"
  })
}

