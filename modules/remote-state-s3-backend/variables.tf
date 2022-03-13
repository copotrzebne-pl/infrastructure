variable "s3_bucket_name" {
  description = "If override_s3_bucket_name is true, use this bucket name for replica instead of dynamic name with bucket_prefix"
  type        = string
  default     = ""
}

variable "region" {
  description = "The AWS region in which resources are set up."
  type        = string
  default     = "eu-central-1"
}

variable "replica_region" {
  description = "The AWS region to which the state bucket is replicated."
  type        = string
  default     = "us-west-1"
}
