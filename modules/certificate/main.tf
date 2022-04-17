provider "aws" {
  region = var.aws_region

}
resource "aws_acm_certificate" "default" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = var.subject_alternative_names

  lifecycle {
    create_before_destroy = true
  }

  provider = aws
}

module "acm-multiple-domains" {
  for_each = { for domain in aws_acm_certificate.default.domain_validation_options : domain.domain_name => domain }

  source  = "cebollia/acm-multiple-domains/aws"
  version = "1.0.1"

  certificate_arn = aws_acm_certificate.default.arn
  domain          = each.key
  name            = each.value.resource_record_name
  type            = each.value.resource_record_type
  record          = each.value.resource_record_value
  ttl             = 3600
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn         = aws_acm_certificate.default.arn
  validation_record_fqdns = [for domain in module.acm-multiple-domains : domain.record.fqdn]
}
