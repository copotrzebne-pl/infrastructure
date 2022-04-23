module "api" {
  source = "../../../stack/api-copotrzebne-pl"

  aws_account_id = var.aws_account_id
  aws_region     = var.aws_region
}
