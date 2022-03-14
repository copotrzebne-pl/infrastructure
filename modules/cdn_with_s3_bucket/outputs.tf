output "cf_id" {
  value       = aws_cloudfront_distribution.default.id
  description = "ID of AWS CloudFront distribution"
}

output "cf_arn" {
  value       = aws_cloudfront_distribution.default.arn
  description = "ARN of AWS CloudFront distribution"
}

output "cf_domain_name" {
  value       = aws_cloudfront_distribution.default.domain_name
  description = "Domain name corresponding to the distribution"
}

output "cf_identity_iam_arn" {
  value       = aws_cloudfront_origin_access_identity.default.iam_arn
  description = "CloudFront Origin Access Identity IAM ARN"
}

output "cf_s3_canonical_user_id" {
  value       = aws_cloudfront_origin_access_identity.default.s3_canonical_user_id
  description = "Canonical user ID for CloudFront Origin Access Identity"
}

output "s3_bucket" {
  value       = aws_s3_bucket.default.bucket
  description = "Name of origin S3 bucket"
}

output "s3_bucket_domain_name" {
  value       = aws_s3_bucket.default.bucket_domain_name
  description = "Domain of origin S3 bucket"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.default.arn
  description = "ARN of origin S3 bucket"
}

output "deployer_user_name" {
  description = "IAM user name"
  value       = aws_iam_user.deployer.name
}

output "deployer_user_arn" {
  description = "The ARN assigned by AWS for user"
  value       = aws_iam_user.deployer.arn
}

output "deployer_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = aws_iam_user.deployer.unique_id
}

output "deployer_access_key_secret" {
  value       = aws_iam_access_key.deployer_access_key.secret
  description = "Secret access key"
  sensitive = true
}

output "deployer_access_key_id" {
  value       = aws_iam_access_key.deployer_access_key.id
  description = "Access key ID"
}
