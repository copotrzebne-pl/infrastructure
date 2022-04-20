output "cf_id" {
  value       = module.cdn.cf_id
  description = "ID of AWS CloudFront distribution"
}

output "s3_deployer_access_key_id" {
  value       = module.cdn.s3_deployer_access_key_id
  description = "Access key ID"
}

output "s3_deployer_access_key_secret" {
  value       = module.cdn.s3_deployer_access_key_secret
  description = "Secret access key"
  sensitive   = true
}

output "s3_deployer_bucket" {
  value       = module.cdn.s3_deployer_bucket
  description = "Bucket name used to host front"
}
