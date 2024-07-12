provider "aws" {
  region = "eu-north-1"
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

locals {
  full_project_name = "local-${var.env}-${var.lesson}"
  project_owner     = "${var.owner} lern terraform in ${var.lesson}"
  az_list           = join(",", data.aws_availability_zones.available.names)
  region            = data.aws_region.current.description
  location          = "In ${local.region} there are AZ: ${local.az_list}"
}

resource "aws_eip" "my_static_ip" {
  tags = {
    "Name"     = "Static IP"
    Owner      = local.project_owner
    CreatedBy  = "Terraform"
    Project    = local.full_project_name
    Env        = var.env
    Region_azs = local.az_list
    Location   = local.location
  }
}
