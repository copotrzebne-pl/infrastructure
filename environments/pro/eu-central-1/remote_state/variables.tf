variable "aws_account_id" {
  description = "AWS account id where resources will be created"
  type        = number
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
}
