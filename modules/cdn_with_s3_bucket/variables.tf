variable "aliases" {
  type = list(object({
    domain  = string
    zone_id = string
  }))
  description = "List of domains and zone ids for CDN"
}

variable "api_domain_name" {
  type        = string
  description = "A domain name for API"

  validation {
    condition     = !can(regex("[A-Z]", var.api_domain_name))
    error_message = "Domain name must be lower-case."
  }
}

variable "comment" {
  type        = string
  description = "Comment for the CloudFront Distribution and Origin Access Identity"
}

variable "acm_certificate_arn" {
  type        = string
  description = "Existing ACM Certificate ARN"
}

variable "static_default_ttl" {
  type        = number
  default     = 60
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "static_min_ttl" {
  type        = number
  default     = 0
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "static_max_ttl" {
  type        = number
  default     = 31536000
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "api_default_ttl" {
  type        = number
  default     = 60
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "api_min_ttl" {
  type        = number
  default     = 0
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "api_max_ttl" {
  type        = number
  default     = 31536000
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of S3 bucket"
}

variable "s3_user_name" {
  type        = string
  description = "The name of the user which will upload files to S3 Bucket"
}
