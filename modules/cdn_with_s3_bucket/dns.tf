resource "aws_route53_record" "default" {
  for_each = { for i, v in var.aliases : i => v }

  zone_id = each.value.zone_id
  name    = each.value.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.default.domain_name
    zone_id                = aws_cloudfront_distribution.default.hosted_zone_id
    evaluate_target_health = true
  }
}
