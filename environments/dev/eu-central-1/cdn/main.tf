module "cdn" {
  source = "../../../../stack/cdn"

  base_domain     = var.base_domain
  base_domain_en  = var.base_domain_en
  base_domain_ua  = var.base_domain_ua
  api_domain_name = var.api_domain_name
}
