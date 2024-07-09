provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "prod_vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "prod"
  }
}

resource "aws_subnet" "prod_subnet_1" {
  vpc_id = data.aws_vpc.data_prod_vpc.id
  availability_zone =  data.aws_availability_zones.working.names[0]
  cidr_block = "10.10.1.0/24"
  tags = {
    Name = "Subnet-1 in ${data.aws_availability_zones.working.names[0]}"
    Account = "Subnet-1 in Account ${data.aws_caller_identity.current.account_id}"
    Region = data.aws_region.current.description
  }
}

resource "aws_subnet" "prod_subnet_2" {
  vpc_id = data.aws_vpc.data_prod_vpc.id
  availability_zone =  data.aws_availability_zones.working.names[1]
  cidr_block = "10.10.2.0/24"
  tags = {
    Name = "Subnet-2 in ${data.aws_availability_zones.working.names[1]}"
    Account = "Subnet-2 in Account ${data.aws_caller_identity.current.account_id}"
    Region = data.aws_region.current.description
  }
}



data "aws_availability_zones" "working" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpcs" "my_vpcs" {}

data "aws_vpc" "data_prod_vpc" {
  tags = {
    Name = "prod"
  }
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_region" {
  value = data.aws_region.current.name
}

output "data_aws_region_description" {
  value = data.aws_region.current.description
}

output "data_aws_vpcs" {
  value = data.aws_vpcs.my_vpcs.ids
}

output "prod_aws_vpc_id" {
  value = data.aws_vpc.data_prod_vpc.id
}

output "prod_aws_vpc_cidr_block" {
  value = data.aws_vpc.data_prod_vpc.cidr_block
}
