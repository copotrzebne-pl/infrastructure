module "acm_request_certificate" {
  source = "cloudposse/acm-request-certificate/aws"
  version = "v0.16.0"
  domain_name                       = var.domain_name
  process_domain_validation_options = true
  ttl                               = "300"
  subject_alternative_names         = ["*.${var.domain_name}"]
}
