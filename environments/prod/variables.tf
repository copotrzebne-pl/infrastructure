variable "aws_account_id" {
  description = "AWS account id where resources will be created"
  type        = number
}

variable "base_domain" {
  description = "Base domain name for the project"
  type        = string
}

variable "api_domain_name" {
  type        = string
  description = "A domain name for API"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
}
