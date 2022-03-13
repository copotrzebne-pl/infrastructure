locals {
  s3_user_name = "deployer-${var.domain}"
  s3_bucket_name = var.domain
  s3_origin_id = "${var.domain}S3Origin"
  acm_certificate = module.acm_certificate.arn
}
