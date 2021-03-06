variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "base_domain" {
  description = "Base domain name for the project"
  type        = string
}

variable "base_domain_en" {
  description = "Base domain name for the project - english version"
  type        = string
}

variable "base_domain_ua" {
  description = "Base domain name for the project - ukraine version"
  type        = string
}

variable "convox_domain" {
  description = "Domain used by Convox ELB"
  type        = string
}
