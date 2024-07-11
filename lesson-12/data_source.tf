data "aws_availability_zones" "availablity_zones" {}

data "aws_ami" "latest_aws_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-*-x86_64-gp2"]
  }
}