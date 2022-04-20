terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-933930654998-eu-central-1"
    key            = "dev/hosting_zones/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:eu-central-1:933930654998:key/2398f819-c84e-4b3c-bf44-20967880fbdf"
    dynamodb_table = "tf-remote-state-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
}

provider "aws" {
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]

  default_tags {
    tags = {
      env       = var.environment
      terraform = true
    }
  }
}
