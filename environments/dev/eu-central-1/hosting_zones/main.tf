module "hosting_zones" {
  source = "../../../../stack/hosting_zones"

  base_domain    = var.base_domain
  base_domain_en = var.base_domain_en
  base_domain_ua = var.base_domain_ua
}
