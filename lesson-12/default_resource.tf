resource "aws_default_vpc" "default" {}

resource "aws_default_subnet" "default_az_1" {
  availability_zone = data.aws_availability_zones.availablity_zones.names[0]
}

resource "aws_default_subnet" "default_az_2" {
  availability_zone = data.aws_availability_zones.availablity_zones.names[1]
}