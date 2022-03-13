resource "aws_iam_user" "user" {
  name = var.deployer_user_name
}

resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.user.name
}
