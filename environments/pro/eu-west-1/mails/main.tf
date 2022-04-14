module "ses" {
  source = "../../../../stack/mails"

  domain                   = var.base_domain
  mail_from_subdomain      = "bounce"
  workmail_organization_id = ""
  workmail_zone            = "eu-west-1"
}
