provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "replica"
  region = var.replica_region
}

locals {
  s3_bucket_name         = "terraform-remote-state-${var.account_id}-${var.region}"
  s3_bucket_name_replica = "terraform-remote-state-${var.account_id}-${var.region}-replica"
}

module "remote_state" {
  source  = "nozaq/remote-state-s3-backend/aws"
  version = "1.1.0"

  override_s3_bucket_name = true
  s3_bucket_name          = local.s3_bucket_name
  s3_bucket_name_replica  = local.s3_bucket_name_replica

  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
}
