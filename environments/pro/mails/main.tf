module "ses" {
  source = "../../../stack/mails"

  domain = var.base_domain
  email  = var.email
}
