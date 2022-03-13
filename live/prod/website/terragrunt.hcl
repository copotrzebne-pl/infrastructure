include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../..//modules/app_website"
}

inputs = {
  domain = "copotrzebne.pl"
  region = local.aws_region
}
