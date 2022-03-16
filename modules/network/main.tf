data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  avalibility_zones_count = length(data.aws_availability_zones.available.names)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.13.0"

  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.available.names
  private_subnets = [for i in range(local.avalibility_zones_count) : "10.0.${i}.0/24"]
  public_subnets  = [for i in range(local.avalibility_zones_count) : "10.0.10${i}.0/24"]
}