locals {
  cdn_domain_name = "www.${var.base_domain}"
}
module "hosting_zone" {
  source = "../../modules/hosting_zone"

  name = var.base_domain
}

module "cdn_certificate" {
  source = "../../modules/certificate"

  domain_name               = var.base_domain
  subject_alternative_names = ["*.${var.base_domain}"]
  zone_id                   = module.hosting_zone.zone_id
  aws_region                = "us-east-1" # CF Certificate need to be created in US-EAST-1
}

module "cdn_with_s3_bucket" {
  source = "../../modules/cdn_with_s3_bucket"

  acm_certificate_arn = module.cdn_certificate.arn
  zone_id             = module.hosting_zone.zone_id
  origin_id           = "s3-bucket-${var.base_domain}"
  s3_user_name        = "ci-s3-website-deployer"

  comment        = local.cdn_domain_name
  domain_name    = local.cdn_domain_name
  s3_bucket_name = local.cdn_domain_name

  # redirect 404s to index.html to make SPA work
  custom_error_response = [{
    error_caching_min_ttl = 60
    error_code            = 404
    response_code         = 200
    response_page_path    = "index.html"
  }]

  custom_origins = [
    {
      domain_name    = "api-copotrzebne-pl.herokuapp.com"
      origin_id      = "api-copotrzebne-heroku"
      origin_path    = null
      custom_headers = null
      custom_origin_config = {
        http_port                = 80
        https_port               = 443
        origin_protocol_policy   = "https-only"
        origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
        origin_keepalive_timeout = 60
        origin_read_timeout      = 60
      }
      s3_origin_config = null
    }
  ]

  ordered_cache = [
    {
      target_origin_id = "api-copotrzebne-heroku"
      path_pattern     = "/api"

      allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
      cached_methods           = ["GET", "HEAD"]
      cache_policy_id          = null
      origin_request_policy_id = null
      compress                 = true

      viewer_protocol_policy = "redirect-to-https"
      min_ttl                = 0
      default_ttl            = 60
      max_ttl                = 3600

      forward_query_string  = true
      forward_header_values = null
      forward_cookies       = "none"
    }
  ]
}

module "remote-state-s3-backend" {
  source = "../../modules/remote-state-s3-backend"

  account_id     = var.aws_account_id
  region         = "eu-central-1"
  replica_region = "us-west-1"
}
