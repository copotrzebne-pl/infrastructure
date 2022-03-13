module "acm_certificate" {
  source = "../acm_certificates"

  domain = var.domain

  providers = {
    aws = aws.us-east-1
  }
}
