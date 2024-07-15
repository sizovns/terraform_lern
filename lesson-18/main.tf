provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = {
      Owner     = "Nikita S"
      CreatedBy = "Terraform"
      Project   = "Terraform Lesson 17"
    }
  }
}

resource "aws_security_group" "webserver" {
  name        = "Security Group"
  description = "Dinamic Security Group"
  vpc_id      = aws_default_vpc.default.id

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

variable "aws_users" {
  description = "List of IAM Users to create"
  default     = ["user1", "user2", "user3", "user4", "user5", "user6"]
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}


resource "aws_instance" "servers" {
  count         = 3
  ami           = data.aws_ami.latest_aws_linux.id
  instance_type = "t3.micro"
  tags = {
    "Name" = "Server Number ${count.index + 1}"
  }
}


output "created_iam_users_all" {
  value = aws_iam_user.users
}

output "created_iam_users_ids" {
  value = aws_iam_user.users[*].id
}

output "created_iam_users_id_and_arn" {
  value = [
    for user in aws_iam_user.users :
    "Username: ${user.name} has ARN: ${user.arn}"
  ]
}

output "created_iam_users_map" {
  value = {
    for user in aws_iam_user.users :
    user.unique_id => user.id
  }
}

output "created_iam_users_if_name" {
  value = [
    for user in aws_iam_user.users :
    user.name
    if user.name == "user1"
  ]
}

output "server_all" {
  value = {
    for server in aws_instance.servers :
    server.id => server.public_ip
  }
}
