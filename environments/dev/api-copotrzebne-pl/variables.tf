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
