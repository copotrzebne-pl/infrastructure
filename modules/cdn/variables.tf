variable "name" {
  type        = string
  description = "List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront"
}

variable "aliases" {
  type        = list(string)
  description = "List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront"
  default     = []
}

variable "parent_zone_id" {
  type        = string
  default     = ""
  description = "ID of the hosted zone to contain this record (or specify `parent_zone_name`). Requires `dns_alias_enabled` set to true"
}

variable "deployer_user_name" {
  type        = string
  default     = ""
  description = "Name of the IAM user with rights to upload code to S3 bucket"
}
