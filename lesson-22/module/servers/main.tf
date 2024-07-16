terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.root,
        aws.dev,
        aws.prod
      ]
    }
  }
}


resource "aws_instance" "my_root_server" {
  provider      = aws.root
  instance_type = var.instance_type
  ami           = data.aws_ami.latest_aws_linux.id
  tags = {
    "Name" = "Default Root Server"
  }
}

resource "aws_instance" "my_dev_server" {
  provider      = aws.dev
  instance_type = var.instance_type
  ami           = data.aws_ami.latest_dev_aws_linux.id
  tags = {
    "Name" = "Default DEV Server"
  }
}


resource "aws_instance" "my_prod_server" {
  provider      = aws.prod
  instance_type = var.instance_type
  ami           = data.aws_ami.latest_prod_aws_linux.id
  tags = {
    "Name" = "Default PROD Server"
  }
}
