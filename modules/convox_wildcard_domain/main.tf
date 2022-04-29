data "aws_route53_zone" "default" {
  name = var.domain
}

data "aws_elb_hosted_zone_id" "default" {}


resource "aws_route53_record" "default" {
  #checkov:skip=CKV2_AWS_23:Convox domain passed by value to work correctly on pro and dev

  zone_id = data.aws_route53_zone.default.zone_id
  name    = "*.${var.domain}"
  type    = "A"

  alias {
    name                   = var.convox_domain
    zone_id                = data.aws_elb_hosted_zone_id.default.id
    evaluate_target_health = true
  }
}
