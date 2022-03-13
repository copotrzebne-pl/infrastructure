output "name_servers" {
  value = aws_route53_zone.main.name_servers
}

output "name" {
  value = aws_route53_zone.main.name
}

output "zone_id" {
  value = aws_route53_zone.main.zone_id
}
