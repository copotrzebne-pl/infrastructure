data "aws_iam_policy_document" "s3_origin" {
  statement {
    sid = "S3GetObjectForCloudFront"

    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.default.id}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.default.iam_arn]
    }
  }

  statement {
    sid = "S3ListBucketForCloudFront"

    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.default.id}"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.default.iam_arn]
    }
  }
}

resource "aws_s3_bucket" "default" {
  #checkov:skip=CKV_AWS_21:Versioning is disabled to save money
  #checkov:skip=CKV_AWS_144:Cross-region replication is disabled to save money
  #checkov:skip=CKV_AWS_18:Access logging is disabled to save money
  #checkov:skip=CKV_AWS_19:Data are encrypted - outdated rule
  #checkov:skip=CKV_AWS_145:Data are encrypted - outdated rule

  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_acl" "default" {
  bucket = aws_s3_bucket.default.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "default" {
  bucket = aws_s3_bucket.default.id
  policy = join("", data.aws_iam_policy_document.s3_origin.*.json)
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.default.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
