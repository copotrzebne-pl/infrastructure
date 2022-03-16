variable "zone_id" {
  type        = string
  description = "ID of the hosted zone where DNS records will be created"
}

variable "domain_name" {
  description = "Domain name for the project"
  type        = string
}

variable "acm_certificate_arn" {
  type        = string
  description = "Existing ACM Certificate ARN"
}

variable "target_url" {
  type        = string
  description = "Target url for redirection"
}
