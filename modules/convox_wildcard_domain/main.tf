data "aws_route53_zone" "default" {
  name = var.domain
}

data "aws_cloudformation_stack" "default" {
  name = var.rack_name
}

data "aws_elb_hosted_zone_id" "default" {}


resource "aws_route53_record" "default" {
  zone_id = data.aws_route53_zone.default.zone_id
  name    = "*.${var.domain}"
  type    = "A"

  alias {
    name                   = data.aws_cloudformation_stack.default.outputs["Domain"]
    zone_id                = data.aws_elb_hosted_zone_id.default.id
    evaluate_target_health = true
  }
}
