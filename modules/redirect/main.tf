data "aws_region" "current" {}

locals {
  bucket_name = aws_s3_bucket.default.bucket
}

resource "aws_cloudfront_distribution" "default" {
  #checkov:skip=CKV_AWS_68:TODO: WAF
  #checkov:skip=CKV2_AWS_32:TODO: security headers policy
  #checkov:skip=CKV_AWS_86:Access logging is disabled to save money

  price_class     = "PriceClass_100"
  comment         = local.bucket_name
  enabled         = true
  is_ipv6_enabled = false

  aliases = [var.domain_name]

  origin {
    domain_name = "${aws_s3_bucket.default.bucket}.s3-website.${data.aws_region.current.name}.amazonaws.com"
    origin_id   = local.bucket_name

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.bucket_name
    compress         = true

    min_ttl     = 31536000
    max_ttl     = 31536000
    default_ttl = 31536000

    forwarded_values {
      headers = []

      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2018"
    cloudfront_default_certificate = false
  }
}
