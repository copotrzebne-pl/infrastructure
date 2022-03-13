output "cf_id" {
  value       = module.cdn.cf_id
  description = "ID of AWS CloudFront distribution"
}

output "cf_arn" {
  value       = module.cdn.cf_arn
  description = "ARN of AWS CloudFront distribution"
}

output "cf_domain_name" {
  value       = module.cdn.cf_domain_name
  description = "Domain name corresponding to the distribution"
}

output "cf_identity_iam_arn" {
  value       = module.cdn.cf_identity_iam_arn
  description = "CloudFront Origin Access Identity IAM ARN"
}

output "cf_s3_canonical_user_id" {
  value       = module.cdn.cf_s3_canonical_user_id
  description = "Canonical user ID for CloudFront Origin Access Identity"
}

output "s3_bucket" {
  value       = module.cdn.s3_bucket
  description = "Name of origin S3 bucket"
}

output "s3_bucket_domain_name" {
  value       = module.cdn.s3_bucket_domain_name
  description = "Domain of origin S3 bucket"
}

output "s3_bucket_arn" {
  value       = module.cdn.s3_bucket_arn
  description = "ARN of origin S3 bucket"
}

output "deployer_user_name" {
  description = "IAM user name"
  value       = aws_iam_user.user.name
}

output "deployer_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = aws_iam_user.user.arn
}

output "deployer_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = aws_iam_user.user.unique_id
}

output "deployer_access_key_secret" {
  value       = aws_iam_access_key.access_key.secret
  description = "Secret access key"
}

output "deployer_access_key_id" {
  value       = aws_iam_access_key.access_key.id
  description = "Access key ID"
}
