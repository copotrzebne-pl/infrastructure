module "convox" {
  source = "../../../../stack/convox"

  base_domain    = var.base_domain
  base_domain_en = var.base_domain_en
  base_domain_ua = var.base_domain_ua
  rack_name      = var.rack_name
  aws_region     = var.aws_region
}
