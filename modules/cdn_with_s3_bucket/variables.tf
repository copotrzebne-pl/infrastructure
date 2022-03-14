variable "domain_name" {
  type        = string
  description = "A domain name for which the certificate should be issued"

  validation {
    condition     = !can(regex("[A-Z]", var.domain_name))
    error_message = "Domain name must be lower-case."
  }
}

variable "comment" {
  type        = string
  description = "Comment for the CloudFront Distribution and Origin Access Identity"
}

variable "custom_error_response" {
  type = list(object({
    error_caching_min_ttl = string
    error_code            = string
    response_code         = string
    response_page_path    = string
  }))

  description = "List of one or more custom error response element maps"
  default     = []
}

variable "ordered_cache" {
  type = list(object({
    target_origin_id = string
    path_pattern     = string

    allowed_methods          = list(string)
    cached_methods           = list(string)
    cache_policy_id          = string
    origin_request_policy_id = string
    compress                 = bool

    viewer_protocol_policy = string
    min_ttl                = number
    default_ttl            = number
    max_ttl                = number

    forward_query_string  = bool
    forward_header_values = list(string)
    forward_cookies       = string
  }))
  default     = []
  description = <<DESCRIPTION
An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence.
The topmost cache behavior will have precedence 0.
The fields can be described by the other variables in this file.
DESCRIPTION
}

variable "custom_origins" {
  type = list(object({
    domain_name = string
    origin_id   = string
    origin_path = string
    custom_headers = list(object({
      name  = string
      value = string
    }))
    custom_origin_config = object({
      http_port                = number
      https_port               = number
      origin_protocol_policy   = string
      origin_ssl_protocols     = list(string)
      origin_keepalive_timeout = number
      origin_read_timeout      = number
    })
    s3_origin_config = object({
      origin_access_identity = string
    })
  }))
  default     = []
  description = <<DESCRIPTION
One or more custom origins for this distribution (multiples allowed). See documentation for configuration options
description https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#origin-arguments
DESCRIPTION
}

variable "acm_certificate_arn" {
  type        = string
  description = "Existing ACM Certificate ARN"
}

variable "default_ttl" {
  type        = number
  default     = 60
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "min_ttl" {
  type        = number
  default     = 0
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "max_ttl" {
  type        = number
  default     = 31536000
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "origin_id" {
  type        = string
  description = "The origin id"
}

variable "zone_id" {
  type        = string
  description = "ID of the hosted zone where DNS records will be created"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of S3 bucket"
}

variable "s3_user_name" {
  type        = string
  description = "The name of the user which will upload files to S3 Bucket"
}
