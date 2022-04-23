data "aws_iam_policy_document" "default" {
  statement {
    sid = "SendEmails"
    actions = [
      "ses:ListTemplates",
      "ses:SendEmail",
      "ses:SendTemplatedEmail",
      "ses:TestRenderTemplate",
      "ses:SendRawEmail",
      "ses:GetTemplate"
    ]
    resources = ["arn:aws:ses:${var.aws_region}:${var.aws_account_id}:*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "default" {
  policy = data.aws_iam_policy_document.default.json
}
