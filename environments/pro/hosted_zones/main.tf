module "hosting_zones" {
  source = "../../../stack/hosted_zones"

  base_domain    = var.base_domain
  base_domain_en = var.base_domain_en
  base_domain_ua = var.base_domain_ua
}

module "dev_domain" {
  source = "../../../modules/domain_delegation"

  name         = "dev.${var.base_domain}"
  zone_id      = module.hosting_zones.zone_id
  name_servers = var.dev_name_severs
}

module "dev_domain_en" {
  source = "../../../modules/domain_delegation"

  name         = "dev.${var.base_domain_en}"
  zone_id      = module.hosting_zones.zone_id_en
  name_servers = var.dev_name_severs_en
}

module "dev_domain_ua" {
  source = "../../../modules/domain_delegation"

  name         = "dev.${var.base_domain_ua}"
  zone_id      = module.hosting_zones.zone_id_ua
  name_servers = var.dev_name_severs_ua
}
