module "remote-state-s3-backend" {
  source = "../../modules/remote-state-s3-backend"

  account_id     = var.aws_account_id
  region         = "eu-central-1"
  replica_region = "us-west-1"
}
