module "hosting_zone" {
  source = "../../modules/hosting_zone"

  name = var.base_domain
}

module "cdn_certificate" {
  source = "../../modules/certificate"

  domain_name = var.base_domain
  zone_id     = module.hosting_zone.zone_id
  providers = { # CF Certificate need to be created in US-EAST-1
    aws = aws.us-east-1
  }
}

module "remote-state-s3-backend" {
  source = "../../modules/remote-state-s3-backend"

  s3_bucket_name = "terraform-remote-state-773224345969-eu-central-1"
}
