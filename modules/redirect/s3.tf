resource "aws_s3_bucket" "default" {
  #checkov:skip=CKV_AWS_21:Versioning is disabled to save money
  #checkov:skip=CKV_AWS_144:Cross-region replication is disabled to save money
  #checkov:skip=CKV_AWS_18:Access logging is disabled to save money
  #checkov:skip=CKV_AWS_19:Data are encrypted - outdated rule
  #checkov:skip=CKV_AWS_145:Data are encrypted - outdated rule
  #checkov:skip=CKV_AWS_20:Bucket should be public read to enable redirect to www. domain

  bucket = var.domain_name
}

resource "aws_s3_bucket_acl" "default" {
  bucket = var.domain_name
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "default" {
  bucket = var.domain_name

  redirect_all_requests_to {
    host_name = var.target_url
  }
}
