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
  aws_region = var.aws_region
}

module "convox_wildcard_domain" {
  source = "../../modules/convox_wildcard_domain"

  domain        = var.base_domain
  convox_domain = var.convox_domain
}

module "convox_wildcard_domain_en" {
  source = "../../modules/convox_wildcard_domain"

  domain        = var.base_domain_en
  convox_domain = var.convox_domain
}

module "convox_wildcard_domain_ua" {
  source = "../../modules/convox_wildcard_domain"

  domain        = var.base_domain_ua
  convox_domain = var.convox_domain
}
