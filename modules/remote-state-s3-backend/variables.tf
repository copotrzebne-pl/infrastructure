variable "s3_bucket_name" {
  description = "Name of the bucket. Replica bucket name will be suffixed with `-replica`."
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
