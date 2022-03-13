include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../..//modules/route53_hosted_zone"
}

inputs = {
  domain      = "copotrzebne.pl"
  environment = local.environment
}
