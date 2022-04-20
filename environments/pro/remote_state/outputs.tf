output "remote_state_bucket" {
  value       = module.state.remote_state_bucket
  description = "The S3 bucket to store the remote state file."
}

output "remote_state_replica_bucket" {
  value       = module.state.remote_state_replica_bucket
  description = "The S3 bucket to replicate the state S3 bucket."
}

output "remote_state_key" {
  value       = module.state.kms_key
  description = "The KMS customer master key to encrypt state buckets."
}
