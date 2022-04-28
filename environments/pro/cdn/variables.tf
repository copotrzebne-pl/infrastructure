variable "aws_account_id" {
  description = "AWS account id where resources will be created"
  type        = number
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
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

variable "api_domain_name" {
  type        = string
  description = "A domain name for API"
}

variable "front_domain_name" {
  type        = string
  description = "A domain name for Front"
}
