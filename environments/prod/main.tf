module "hosting_zone" {
  source = "../../modules/hosting_zone"

  name = var.base_domain
}

module "certificate" {
  source = "../../modules/certificate"

  domain_name = var.base_domain
}

module "cdn" {
  source = "../../modules/cdn"

  name                = "www.${var.base_domain}"
  aliases             = ["www.${var.base_domain}"]
  parent_zone_id      = module.hosting_zone.zone_id
  acm_certificate_arn = module.certificate.arn
  deployer_user_name  = "ci-website-deployer"
}

module "remote-state-s3-backend" {
  source = "../../modules/remote-state-s3-backend"

  s3_bucket_name = "terraform-remote-state-773224345969-eu-central-1"
}
