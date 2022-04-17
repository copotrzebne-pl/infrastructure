resource "aws_route53_record" "default" {
  allow_overwrite = true
  name            = var.name
  ttl             = 172800
  type            = "NS"
  zone_id         = var.zone_id

  records = var.name_servers
}
