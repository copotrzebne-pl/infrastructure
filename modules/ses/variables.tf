variable "domain" {
  description = "Domain name'"
  type        = number
}

variable "mail_from_subdomain" {
  description = "Subdomain which is to be used as MAIL FROM address (Required for DMARC validation)"
  type        = string
  default     = "mail"
}

variable "emails" {
  type        = list(string)
  description = "List of emails identity"
  default     = []
}

variable "workmail_zone" {
  type        = string
  description = "AWS Zone of the WorkMail Organization"
  default     = ""
}
variable "workmail_organization_id" {
  type        = string
  description = "WorkMail Organization Id"
  default     = ""
}
