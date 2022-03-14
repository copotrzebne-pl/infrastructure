variable "allowed_account_id" {
  description = "Allowed AWS account id where resources can be created"
  type        = string
}

variable "base_domain" {
  description = "Base domain name for the project"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
}
