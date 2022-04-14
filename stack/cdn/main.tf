data "aws_route53_zone" "pl" {
  name = "${var.base_domain}."
}

data "aws_route53_zone" "en" {
  name = "${var.base_domain_en}."
}

data "aws_route53_zone" "ua" {
  name = "${var.base_domain_ua}."
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

module "cdn_with_s3_bucket" {
  source = "../../modules/cdn_with_s3_bucket"

  acm_certificate_arn = module.cdn_certificate.arn
  s3_user_name        = "ci-s3-website-deployer"
  s3_bucket_name      = var.base_domain
  api_domain_name     = var.api_domain_name
  comment             = var.base_domain
  aliases = [
    {
      domain  = var.base_domain,
      zone_id = data.aws_route53_zone.pl.zone_id
      }, {
      domain  = var.base_domain_ua,
      zone_id = data.aws_route53_zone.ua.zone_id
      }, {
      domain  = var.base_domain_en,
      zone_id = data.aws_route53_zone.en.zone_id
    }
  ]
}

module "redirect" {
  source = "../../modules/redirect"

  acm_certificate_arn = module.cdn_certificate.arn
  zone_id             = data.aws_route53_zone.pl.zone_id
  domain_name         = "www.${var.base_domain}"
  target_url          = var.base_domain
}

module "redirect_en" {
  source = "../../modules/redirect"

  acm_certificate_arn = module.cdn_certificate.arn
  zone_id             = data.aws_route53_zone.en.zone_id
  domain_name         = "www.${var.base_domain_en}"
  target_url          = var.base_domain_en
}

module "redirect_ua" {
  source = "../../modules/redirect"

  acm_certificate_arn = module.cdn_certificate.arn
  zone_id             = data.aws_route53_zone.ua.zone_id
  domain_name         = "www.${var.base_domain_ua}"
  target_url          = var.base_domain_ua
}
