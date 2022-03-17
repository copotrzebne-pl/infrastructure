data "aws_ssm_parameter" "db_credentials" {
  name = "/prod/database/credentials"
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
  database_name     = "copotrzebne"
  db_credentials    = local.db_credentials
}
