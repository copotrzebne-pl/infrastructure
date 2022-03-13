module "cdn" {
  source = "cloudposse/cloudfront-s3-cdn/aws"
  version = "v0.82.3"

  name              = var.name
  aliases           = var.aliases
  dns_alias_enabled = true
  parent_zone_id  = var.parent_zone_id
  allowed_methods = [ "GET", "HEAD", "OPTIONS"]

  deployment_principal_arns = {
    (aws_iam_user.deployer.arn) = [""]
  }

  depends_on = [aws_iam_user.deployer]
}
