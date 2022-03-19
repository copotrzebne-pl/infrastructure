data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  availability_zones_count = length(data.aws_availability_zones.available.names)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.13.0"

  name = var.name
  cidr = "10.0.0.0/16"

  azs              = data.aws_availability_zones.available.names
  private_subnets  = [for i in range(local.availability_zones_count) : "10.0.${i}.0/24"]
  public_subnets   = [for i in range(local.availability_zones_count) : "10.0.10${i}.0/24"]
  database_subnets = [for i in range(local.availability_zones_count) : "10.0.20${i}.0/24"]
}
