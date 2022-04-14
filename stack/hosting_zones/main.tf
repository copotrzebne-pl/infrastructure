module "hosting_zone" {
  source = "../../modules/hosting_zone"

  name = var.base_domain
}

module "hosting_zone_en" {
  source = "../../modules/hosting_zone"

  name = var.base_domain_en
}

module "hosting_zone_ua" {
  source = "../../modules/hosting_zone"

  name = var.base_domain_ua
}
