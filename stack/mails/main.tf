data "aws_region" "current" {}

data "aws_route53_zone" "domain" {
  name         = var.domain
  private_zone = false
}

provider "aws" {
  alias  = "eu-west"
  region = "eu-west-1"
}

module "ses-eu-west" {
  source  = "umotif-public/ses-domain/aws"
  version = "~> 2.0.2"

  providers = {
    aws = aws.eu-west
  }

  zone_id                           = data.aws_route53_zone.domain.zone_id
  enable_verification               = true
  additional_verification_tokens    = [module.ses-eu-west.ses_domain_identity_verification_token]
  additional_mail_from_records      = ["10 feedback-smtp.eu-west-1.amazonses.com"]
  additional_incoming_email_records = ["10 inbound-smtp.eu-west-1.amazonaws.com"]
}

module "ses-eu-central" {
  source  = "umotif-public/ses-domain/aws"
  version = "~> 2.0.2"

  zone_id                    = data.aws_route53_zone.domain.zone_id
  enable_verification        = true
  enable_verification_record = false

  enable_spf_record = false

  enable_from_domain_record    = false
  enable_incoming_email_record = false
}

resource "aws_ses_email_identity" "email" {
  email = var.email
}

resource "aws_route53_record" "autodiscover" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "autodiscover.${var.domain}"
  type    = "CNAME"
  ttl     = 86400
  records = ["autodiscover.mail.eu-west-1.awsapps.com."]
}

resource "aws_route53_record" "dmarc" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "_dmarc.${var.domain}"
  type    = "TXT"
  ttl     = 86400
  records = ["v=DMARC1;p=quarantine;pct=100;fo=1"]
}
