data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  use_workmail = var.workmail_organization_id ? 1 : 0
}
// domain
resource "aws_ses_domain_identity" "default" {
  domain = var.domain
}

data "aws_route53_zone" "domain" {
  name = var.domain
}

resource "aws_route53_record" "verification" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.default.id}"
  type    = "TXT"
  ttl     = 600
  records = [aws_ses_domain_identity.default.verification_token]
}

resource "aws_ses_domain_identity_verification" "example_verification" {
  domain = aws_ses_domain_identity.default.id

  depends_on = [aws_route53_record.verification]
}

// dkim
resource "aws_ses_domain_dkim" "default" {
  domain = aws_ses_domain_identity.default.domain
}

resource "aws_route53_record" "dkim" {
  count   = 3
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "${element(aws_ses_domain_dkim.default.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.default.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

// dmarc
resource "aws_route53_record" "dmarc" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "_dmarc.${var.domain}"
  type    = "TXT"
  ttl     = 86400
  records = ["v=DMARC1;p=quarantine;pct=100;fo=1"]
}

// workmail
resource "aws_route53_record" "autodiscover" {
  count = local.use_workmail ? 1 : 0

  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "autodiscover.${var.domain}"
  type    = "CNAME"
  ttl     = 86400
  records = ["autodiscover.mail.${data.aws_region.current.name}.awsapps.com."]
}

resource "aws_route53_record" "mx" {
  count = local.use_workmail ? 1 : 0

  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.domain
  type    = "MX"
  ttl     = 300
  records = ["10 inbound-smtp.${var.workmail_zone}.amazonaws.com."]
}

resource "aws_route53_record" "spf" {
  count = local.use_workmail ? 1 : 0

  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.domain
  type    = "TXT"
  ttl     = 86400
  records = ["v=spf1 include:amazonses.com ~all"]
}

// mail from
resource "aws_ses_domain_mail_from" "default" {
  domain           = aws_ses_domain_identity.default.domain
  mail_from_domain = "${var.mail_from_subdomain}.${aws_ses_domain_identity.default.domain}"
}

resource "aws_route53_record" "mx_from_domain" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = aws_ses_domain_mail_from.default.mail_from_domain
  type    = "MX"
  ttl     = 300
  records = ["10 feedback-smtp.${data.aws_region.current.name}.amazonses.com"]
}

resource "aws_route53_record" "spf_from_domain" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = aws_ses_domain_mail_from.default.mail_from_domain
  type    = "TXT"
  ttl     = 300
  records = ["v=spf1 include:amazonses.com ~all"]
}

// policy
data "aws_iam_policy_document" "default" {
  count = local.use_workmail ? 1 : 0

  statement {
    sid       = "AuthorizeWorkMail"
    effect    = "Allow"
    actions   = ["SES:*"]
    resources = [aws_ses_domain_identity.default.arn]

    principals {
      identifiers = ["workmail.${var.workmail_zone}.amazonaws.com"]
      type        = "Service"
    }
    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:workmail:${var.workmail_zone}:${data.aws_caller_identity.current.account_id}:organization/${var.workmail_organization_id}"]
    }
  }
}

resource "aws_ses_identity_policy" "default" {
  count = local.use_workmail ? 1 : 0

  identity = aws_ses_domain_identity.default.arn
  name     = "workmail-${var.workmail_organization_id}"
  policy   = data.aws_iam_policy_document.default[*].json
}

// email identities
resource "aws_ses_email_identity" "default" {
  for_each = var.emails
  email    = each.value
}
