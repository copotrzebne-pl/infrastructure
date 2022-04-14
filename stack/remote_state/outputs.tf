output "remote_state_bucket" {
  value       = module.remote-state-s3-backend.state_bucket
  description = "The S3 bucket to store the remote state file."
}

output "remote_state_replica_bucket" {
  value       = module.remote-state-s3-backend.replica_bucket
  description = "The S3 bucket to replicate the state S3 bucket."
}

output "kms_key" {
  description = "The KMS customer master key to encrypt state buckets."
  value       = module.remote-state-s3-backend.kms_key
}
