output "remote_state_bucket" {
  value       = module.remote-state-s3-backend.state_bucket
  description = "The S3 bucket to store the remote state file."
}

output "remote_state_replica_bucket" {
  value       = module.remote-state-s3-backend.replica_bucket
  description = "The S3 bucket to replicate the state S3 bucket."
}

output "s3_deployer_access_key_id" {
  value       = module.cdn_with_s3_bucket.deployer_access_key_id
  description = "Access key ID"
}

output "s3_deployer_access_key_secret" {
  value       = module.cdn_with_s3_bucket.deployer_access_key_secret
  description = "Secret access key"
  sensitive   = true
}

output "s3_deployer_bucket" {
  value       = module.cdn_with_s3_bucket.s3_bucket
  description = "Bucket name used to host front"
}

output "zone_name_servers" {
  value       = module.hosting_zone.name_servers
  description = "A list of name servers in associated (or default) delegation set"
}

output "zone_name_servers_en" {
  value       = module.hosting_zone_en.name_servers
  description = "A list of name servers in associated (or default) delegation set - EN"
}

output "zone_name_servers_ua" {
  value       = module.hosting_zone_ua.name_servers
  description = "A list of name servers in associated (or default) delegation set - UA"
}
