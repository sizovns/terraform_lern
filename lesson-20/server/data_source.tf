data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "nikita-s-terraform-state"
    key    = "dev/network/terraform.tfstate"
    region = "eu-north-1"
  }
}

data "aws_ami" "latest_aws_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-*-x86_64-gp2"]
  }
}
