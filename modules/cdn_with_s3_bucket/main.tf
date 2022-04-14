locals {
  origin_id = "s3-bucket-${var.s3_bucket_name}"
}

resource "aws_cloudfront_origin_access_identity" "default" {
  comment = var.comment
}

resource "aws_cloudfront_distribution" "default" {
  #checkov:skip=CKV_AWS_68:TODO: WAF
  #checkov:skip=CKV2_AWS_32:TODO: security headers policy
  #checkov:skip=CKV_AWS_86:Access logging is disabled to save money

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.comment
  default_root_object = "index.html"
  price_class         = "PriceClass_100"

  aliases = var.aliases[*].domain

  custom_error_response {
    error_caching_min_ttl = 60
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  origin {
    domain_name = aws_s3_bucket.default.bucket_regional_domain_name
    origin_id   = local.origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path
    }
  }

  origin {
    domain_name = var.api_domain_name
    origin_id   = "api-copotrzebne"
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "https-only"
      origin_ssl_protocols     = ["TLSv1.2"]
      origin_keepalive_timeout = 60
      origin_read_timeout      = 60
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2018"
    cloudfront_default_certificate = false
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.origin_id
    compress         = true

    forwarded_values {
      headers = []

      query_string = false

      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    default_ttl            = var.static_default_ttl
    min_ttl                = var.static_min_ttl
    max_ttl                = var.static_max_ttl
  }

  ordered_cache_behavior {
    target_origin_id = "api-copotrzebne"
    path_pattern     = "/api/*"

    allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods           = ["GET", "HEAD"]
    cache_policy_id          = null
    origin_request_policy_id = null
    compress                 = true

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.api_min_ttl
    default_ttl            = var.api_default_ttl
    max_ttl                = var.api_max_ttl

    forwarded_values {
      headers = ["Authorization", "Origin", "Access-Control-Request-Headers", "Access-Control-Request-Method", "Host"]

      query_string = true

      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
}
