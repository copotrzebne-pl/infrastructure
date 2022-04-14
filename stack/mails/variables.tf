variable "domain" {
  description = "Base domain name for the project"
  type        = string
}

variable "workmail_organization_id" {
  description = "Workmail organization id"
  type        = string
}

variable "workmail_zone" {
  description = "Workmail zone"
  type        = string
  default     = "eu-west-1"
}

variable "mail_from_subdomain" {
  description = "Subdomain which is to be used as MAIL FROM address (Required for DMARC validation)"
  type        = string
}
