resource "aws_iam_user" "deployer" {
  name = var.s3_user_name
}

data "aws_iam_policy_document" "deployer_policy" {
  statement {
    sid = "s3ReadDeployer"
    actions = [
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = ["${aws_s3_bucket.default.arn}/*"]
    effect    = "Allow"
  }

  statement {
    sid = "s3ReadDeployerBucket"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [aws_s3_bucket.default.arn]
    effect    = "Allow"
  }

  statement {
    sid = "s3ReadCfInvatigation"
    actions = [
      "cloudfront:CreateInvalidation"
    ]
    resources = [aws_cloudfront_distribution.default.arn]
    effect    = "Allow"
  }

  depends_on = [aws_s3_bucket.default, aws_cloudfront_distribution.default]
}

resource "aws_iam_user_policy" "deployer_policy" {
  #checkov:skip=CKV_AWS_40:TODO: We should skip to assume role
  name   = aws_iam_user.deployer.name
  user   = aws_iam_user.deployer.name
  policy = join("", data.aws_iam_policy_document.deployer_policy.*.json)
}

resource "aws_iam_access_key" "deployer_access_key" {
  user = aws_iam_user.deployer.name
}
