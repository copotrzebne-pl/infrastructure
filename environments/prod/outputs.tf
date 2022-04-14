output "remote_state_bucket" {
  value       = module.remote-state-s3-backend.state_bucket
  description = "The S3 bucket to store the remote state file."
}

output "remote_state_replica_bucket" {
  value       = module.remote-state-s3-backend.replica_bucket
  description = "The S3 bucket to replicate the state S3 bucket."
}

output "s3_deployer_user_name" {
  value       = module.cdn_with_s3_bucket.deployer_user_name
  description = "IAM user name"
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

output "zone_id" {
  value       = module.hosting_zone.zone_id
  description = "The Hosted Zone ID"
}

output "zone_name" {
  description = "Name of the hosted zone."
  value       = module.hosting_zone.name
}

output "zone_name_servers" {
  value       = module.hosting_zone.name_servers
  description = "A list of name servers in associated (or default) delegation set"
}

output "zone_id_en" {
  value       = module.hosting_zone_en.zone_id
  description = "The Hosted Zone ID - EN"
}

output "zone_name_en" {
  description = "Name of the hosted zone - EN."
  value       = module.hosting_zone_en.name
}

output "zone_name_servers_en" {
  value       = module.hosting_zone_en.name_servers
  description = "A list of name servers in associated (or default) delegation set - EN"
}

output "zone_id_ua" {
  value       = module.hosting_zone_ua.zone_id
  description = "The Hosted Zone ID - UA"
}

output "zone_name_ua" {
  description = "Name of the hosted zone - UA."
  value       = module.hosting_zone_ua.name
}

output "zone_name_servers_ua" {
  value       = module.hosting_zone_ua.name_servers
  description = "A list of name servers in associated (or default) delegation set - UA"
}
