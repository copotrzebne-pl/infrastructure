data "aws_caller_identity" "default" {}

resource "aws_s3_bucket" "default" {
  #checkov:skip=CKV_AWS_18:Access logging is disabled to save money
  #checkov:skip=CKV_AWS_19:Data are encrypted - outdated rule
  #checkov:skip=CKV_AWS_20:Public access can't be blocked to enable redirect
  #checkov:skip=CKV_AWS_21:Versioning is disabled to save money
  #checkov:skip=CKV_AWS_57:public-read ACL allows only public read. The rule is broken.
  #checkov:skip=CKV_AWS_144:Cross-region replication is disabled to save money
  #checkov:skip=CKV_AWS_145:Data are encrypted - outdated rule
  #checkov:skip=CKV2_AWS_6:Public access can't be blocked to enable redirect
  #checkov:skip=CKV2_AWS_37:Versioning is disabled to save money
  #checkov:skip=CKV2_AWS_38:Allow public read, because is necessary
  #checkov:skip=CKV2_AWS_40:Data are encrypted
  #checkov:skip=CKV2_AWS_41:Access logging is disabled to save money

  bucket = "redirect-${data.aws_caller_identity.default.account_id}-${var.domain_name}"
}

resource "aws_s3_bucket_acl" "default" {
  bucket = aws_s3_bucket.default.bucket
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "default" {
  bucket = aws_s3_bucket.default.bucket

  redirect_all_requests_to {
    host_name = var.target_url
  }
}
