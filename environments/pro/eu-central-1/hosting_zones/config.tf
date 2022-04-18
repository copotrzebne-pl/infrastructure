terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-432456784825-eu-central-1"
    key            = "pro/hosting_zones/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:eu-central-1:432456784825:key/a0714922-c1d8-4d01-b4fc-0ae98fa3a7e3"
    dynamodb_table = "tf-remote-state-lock"
    profile        = "copotrzebne-pro"
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
  profile             = "copotrzebne-pro"
  allowed_account_ids = [var.aws_account_id]

  default_tags {
    tags = {
      env       = var.environment
      terraform = true
    }
  }
}
