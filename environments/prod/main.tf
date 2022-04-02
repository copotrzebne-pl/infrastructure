data "aws_ssm_parameter" "db_credentials" {
  name = "/prod/database/credentials"
}

data "terraform_remote_state" "api" {
  backend = "api"
}

locals {
  cdn_domain_name = "www.${var.base_domain}"
  db_credentials  = jsondecode(data.aws_ssm_parameter.db_credentials.value)
}

module "hosting_zone" {
  source = "../../modules/hosting_zone"

  name = var.base_domain
}

module "cdn_certificate" {
  source = "../../modules/certificate"

  domain_name               = var.base_domain
  subject_alternative_names = ["*.${var.base_domain}"]
  zone_id                   = module.hosting_zone.zone_id
  aws_region                = "us-east-1" # CF Certificate need to be created in US-EAST-1
}

module "cdn_certificate_regional" {
  source = "../../modules/certificate"

  domain_name               = var.base_domain
  subject_alternative_names = ["*.${var.base_domain}"]
  zone_id                   = module.hosting_zone.zone_id
  aws_region                = var.aws_region
}

module "cdn_with_s3_bucket" {
  source = "../../modules/cdn_with_s3_bucket"

  acm_certificate_arn = module.cdn_certificate.arn
  zone_id             = module.hosting_zone.zone_id
  s3_user_name        = "ci-s3-website-deployer"

  comment         = local.cdn_domain_name
  domain_name     = local.cdn_domain_name
  s3_bucket_name  = local.cdn_domain_name
  api_domain_name = var.api_domain_name
}

module "remote-state-s3-backend" {
  source = "../../modules/remote-state-s3-backend"

  account_id     = var.aws_account_id
  region         = "eu-central-1"
  replica_region = "us-west-1"
}

module "network" {
  source = "../../modules/network"
  name   = "${var.stack_name}-network"
}

module "redirect" {
  source = "../../modules/redirect"

  acm_certificate_arn = module.cdn_certificate.arn
  zone_id             = module.hosting_zone.zone_id
  domain_name         = var.base_domain
  target_url          = local.cdn_domain_name
}

module "rds" {
  source = "../../modules/rds"

  subnet_group_name = module.network.db_subnet_group_name
  name              = var.stack_name
  database_name     = "copotrzebne"
  db_credentials    = local.db_credentials
  vpc_id            = module.network.vpc_id
}

module "container_repository" {
  source = "../../modules/container_repository"

  name = "${var.stack_name}-container-repository"
}

module "container_orchestrator" {
  source = "../../modules/ecs"

  name          = "${var.stack_name}-ecs"
  instance_type = "t2.micro"

  scaling = {
    min_size         = 0
    max_size         = 1
    desired_capacity = 1
  }

  network = {
    assign_instance_public_ips = false
    subnets                    = module.network.private_subnets
    security_groups            = [module.network.default_security_group]
  }
}

module "load_balancer" {
  source = "../../modules/load_balancer"
  name   = "${var.stack_name}-default-alb"

  network = {
    vpc_id          = module.network.vpc_id
    private_subnets = module.network.private_subnets
    public_subnets  = module.network.public_subnets
    security_groups = [module.network.default_security_group] #TODO: verify if we can allow less
  }
  default_target_group_arn = data.terraform_remote_state.api.target_group_arn
  certificate_arn          = module.cdn_certificate_regional.arn
  zone_id                  = module.hosting_zone.zone_id
  domain_name              = "api.${var.base_domain}"
}
