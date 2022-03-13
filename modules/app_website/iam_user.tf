data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:ListBucketMultipartUploads"
    ]
    resources = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
    effect    = "Allow"
  }

  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}"
    effect    = "Allow"
  }
}

resource "aws_iam_user" "s3_user" {
  name = "local.s3_user_name"
}

resource "aws_iam_user_policy" "s3_user_policy" {
  name   = aws_iam_user.s3_user.name
  user   = aws_iam_user.s3_user.name
  policy = join("", data.aws_iam_policy_document.default.*.json)
}
