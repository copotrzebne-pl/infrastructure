locals {
  cdn_domain_name    = "www.${var.base_domain}"
  cdn_domain_name_en = "www.${var.base_domain_en}"
  cdn_domain_name_ua = "www.${var.base_domain_ua}"
}

module "hosting_zone" {
  source = "../../modules/hosting_zone"

  name = var.base_domain
}

module "hosting_zone_en" {
  source = "../../modules/hosting_zone"

  name = var.base_domain_en
}

module "hosting_zone_ua" {
  source = "../../modules/hosting_zone"

  name = var.base_domain_ua
}

module "cdn_certificate" {
  source = "../../modules/certificate"

  domain_name = var.base_domain
  subject_alternative_names = [
    "*.${var.base_domain}",
    "*.${var.base_domain_en}",
    "*.${var.base_domain_ua}",
    var.base_domain_en,
    var.base_domain_ua
  ]
  aws_region = "us-east-1" # CF Certificate need to be created in US-EAST-1
}

module "cdn_certificate_regional" {
  source = "../../modules/certificate"

  domain_name               = var.base_domain
  subject_alternative_names = ["*.${var.base_domain}"]

  aws_region = var.aws_region
}

module "cdn_with_s3_bucket" {
  source = "../../modules/cdn_with_s3_bucket"

  acm_certificate_arn = module.cdn_certificate.arn
  s3_user_name        = "ci-s3-website-deployer"

  comment = local.cdn_domain_name
  aliases = [
    {
      domain  = local.cdn_domain_name,
      zone_id = module.hosting_zone.zone_id
      }, {
      domain  = local.cdn_domain_name_ua,
      zone_id = module.hosting_zone_ua.zone_id
      }, {
      domain  = local.cdn_domain_name_en,
      zone_id = module.hosting_zone_en.zone_id
    }
  ]
  s3_bucket_name  = local.cdn_domain_name
  api_domain_name = var.api_domain_name
}

module "remote-state-s3-backend" {
  source = "../../modules/remote-state-s3-backend"

  account_id     = var.aws_account_id
  region         = "eu-central-1"
  replica_region = "us-west-1"
}

module "redirect" {
  source = "../../modules/redirect"

  acm_certificate_arn = module.cdn_certificate.arn
  zone_id             = module.hosting_zone.zone_id
  domain_name         = var.base_domain
  target_url          = local.cdn_domain_name
}

module "redirect_en" {
  source = "../../modules/redirect"

  acm_certificate_arn = module.cdn_certificate.arn
  zone_id             = module.hosting_zone_en.zone_id
  domain_name         = var.base_domain_en
  target_url          = local.cdn_domain_name_en
}

module "redirect_ua" {
  source = "../../modules/redirect"

  acm_certificate_arn = module.cdn_certificate.arn
  zone_id             = module.hosting_zone_ua.zone_id
  domain_name         = var.base_domain_ua
  target_url          = local.cdn_domain_name_ua
}

module "beta_domain" {
  source = "../../modules/domain_delegation"

  name         = "beta.${var.base_domain}"
  zone_id      = module.hosting_zone.zone_id
  name_servers = var.beta_name_servers
}

module "beta_domain_en" {
  source = "../../modules/domain_delegation"

  name         = "beta.${var.base_domain_en}"
  zone_id      = module.hosting_zone_en.zone_id
  name_servers = var.beta_name_servers_en
}

module "beta_domain_ua" {
  source = "../../modules/domain_delegation"

  name         = "beta.${var.base_domain_ua}"
  zone_id      = module.hosting_zone_ua.zone_id
  name_servers = var.beta_name_servers_ua
}
