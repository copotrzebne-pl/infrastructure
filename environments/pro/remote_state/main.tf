module "state" {
  source = "../../../stack/remote_state"

  aws_region     = var.aws_region
  aws_account_id = var.aws_account_id
  environment    = var.environment
}
