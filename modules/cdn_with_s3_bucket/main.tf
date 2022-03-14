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

  aliases = [var.domain_name]

  dynamic "custom_error_response" {
    for_each = var.custom_error_response
    content {
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
      error_code            = custom_error_response.value.error_code
      response_code         = lookup(custom_error_response.value, "response_code", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
    }
  }

  origin {
    domain_name = aws_s3_bucket.default.bucket_regional_domain_name
    origin_id   = var.origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path
    }
  }

  dynamic "origin" {
    for_each = var.custom_origins
    content {
      domain_name = origin.value.domain_name
      origin_id   = origin.value.origin_id
      origin_path = lookup(origin.value, "origin_path", "")

      dynamic "custom_origin_config" {
        for_each = lookup(origin.value, "custom_origin_config", null) == null ? [] : [true]
        content {
          http_port                = lookup(origin.value.custom_origin_config, "http_port", null)
          https_port               = lookup(origin.value.custom_origin_config, "https_port", null)
          origin_protocol_policy   = lookup(origin.value.custom_origin_config, "origin_protocol_policy", "https-only")
          origin_ssl_protocols     = lookup(origin.value.custom_origin_config, "origin_ssl_protocols", ["TLSv1.2"])
          origin_keepalive_timeout = lookup(origin.value.custom_origin_config, "origin_keepalive_timeout", 60)
          origin_read_timeout      = lookup(origin.value.custom_origin_config, "origin_read_timeout", 60)
        }
      }
      dynamic "s3_origin_config" {
        for_each = lookup(origin.value, "s3_origin_config", null) == null ? [] : [true]
        content {
          origin_access_identity = lookup(origin.value.s3_origin_config, "origin_access_identity", null)
        }
      }
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
    target_origin_id = var.origin_id
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
    default_ttl            = var.default_ttl
    min_ttl                = var.min_ttl
    max_ttl                = var.max_ttl
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_cache

    content {
      path_pattern = ordered_cache_behavior.value.path_pattern

      allowed_methods          = ordered_cache_behavior.value.allowed_methods
      cached_methods           = ordered_cache_behavior.value.cached_methods
      cache_policy_id          = ordered_cache_behavior.value.cache_policy_id
      origin_request_policy_id = ordered_cache_behavior.value.origin_request_policy_id
      target_origin_id         = ordered_cache_behavior.value.target_origin_id == "" ? var.origin_id : ordered_cache_behavior.value.target_origin_id
      compress                 = ordered_cache_behavior.value.compress

      dynamic "forwarded_values" {
        # If a cache policy or origin request policy is specified, we cannot include a `forwarded_values` block at all in the API request
        for_each = try(coalesce(ordered_cache_behavior.value.cache_policy_id), null) == null && try(coalesce(ordered_cache_behavior.value.origin_request_policy_id), null) == null ? [
          true
        ] : []
        content {
          query_string = ordered_cache_behavior.value.forward_query_string
          headers      = ordered_cache_behavior.value.forward_header_values

          cookies {
            forward = ordered_cache_behavior.value.forward_cookies
          }
        }
      }

      viewer_protocol_policy = ordered_cache_behavior.value.viewer_protocol_policy
      default_ttl            = ordered_cache_behavior.value.default_ttl
      min_ttl                = ordered_cache_behavior.value.min_ttl
      max_ttl                = ordered_cache_behavior.value.max_ttl
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
}

resource "aws_cloudfront_response_headers_policy" "default" {
  name    = "example-policy"
  comment = "test comment"

  cors_config {
    access_control_allow_credentials = true

    access_control_allow_headers {
      items = ["test"]
    }

    access_control_allow_methods {
      items = ["GET"]
    }

    access_control_allow_origins {
      items = ["test.example.comtest"]
    }

    origin_override = true
  }
}
