module "ses" {
  source = "../../modules/ses"

  domain                   = var.domain
  mail_from_subdomain      = var.mail_from_subdomain
  workmail_organization_id = var.workmail_organization_id
  workmail_zone            = var.workmail_zone
}
