provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "replica"
  region = var.replica_region
}

module "remote_state" {
  source = "nozaq/remote-state-s3-backend/aws"

  override_s3_bucket_name = true
  s3_bucket_name          = var.s3_bucket_name
  s3_bucket_name_replica  = "${var.s3_bucket_name}-replica"

  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
}
