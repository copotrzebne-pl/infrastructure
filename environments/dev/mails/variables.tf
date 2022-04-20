variable "aws_account_id" {
  description = "AWS account id where resources will be created"
  type        = number
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

variable "email" {
  description = "Email identity"
  type        = string
}
