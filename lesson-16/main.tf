provider "aws" {
  region = "eu-north-1"
}

variable "change_db_pass1" {
  default = "db_pass_2"
}

resource "random_string" "rds_password" {
  length           = 12
  special          = true
  override_special = "!#$&"
  keepers = {
    "keeper1" = var.change_db_pass1
  }
}

resource "aws_ssm_parameter" "rds_password" {
  name        = "/prod/mysql"
  type        = "SecureString"
  description = "Master Password for MySQL"
  value       = random_string.rds_password.result
}

data "aws_ssm_parameter" "my_rds_password" {
  name       = "/prod/mysql"
  depends_on = [aws_ssm_parameter.rds_password]
}


resource "aws_db_instance" "prod_rds" {
  identifier           = "prod-rds"
  allocated_storage    = 10
  db_name              = "prod"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = data.aws_ssm_parameter.my_rds_password.value
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  apply_immediately    = true
  tags = {
    "PasswordContainer" = data.aws_ssm_parameter.my_rds_password.name
  }
}

output "rds_password" {
  value     = data.aws_ssm_parameter.my_rds_password.value
  sensitive = true
}
