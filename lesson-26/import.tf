provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "my_imported_instance" {
  ami                    = "ami-0249211c9916306f8"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.wizard_sg.id]
  tags = {
    Name  = "import test"
    Owner = "Terraform"
  }
}

resource "aws_security_group" "wizard_sg" {
  description = "launch-wizard-1 created 2024-07-22T08:45:30.803Z"
  ingress {
    cidr_blocks = [
      "0.0.0.0/0",
    ]
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
  }

  egress {
    cidr_blocks = [
      "0.0.0.0/0",
    ]
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }

  tags = {
    Name  = "terraform-wizard-1"
    Owner = "Terraform"
  }

}
