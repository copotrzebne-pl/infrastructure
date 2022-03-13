variable "allowed_account_ids" {
  description = "List of allowed AWS account ids where resources can be created"
  type        = list(string)
  default     = []
}

variable "base_domain" {
  description = "Based domain name for the project"
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
