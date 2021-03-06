variable "domain_name" {
  type        = string
  description = "A domain name for which the certificate should be issued"

  validation {
    condition     = !can(regex("[A-Z]", var.domain_name))
    error_message = "Domain name must be lower-case."
  }
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "A list of domains that should be SANs in the issued certificate"

  validation {
    condition     = length([for name in var.subject_alternative_names : name if can(regex("[A-Z]", name))]) == 0
    error_message = "All SANs must be lower-case."
  }
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}
