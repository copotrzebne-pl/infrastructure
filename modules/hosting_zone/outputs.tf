output "name_servers" {
  description = "A list of name servers in associated (or default) delegation set"
  value       = aws_route53_zone.default.name_servers
}

output "name" {
  description = "Name of the hosted zone."
  value       = aws_route53_zone.default.name
}

output "zone_id" {
  description = "The Hosted Zone ID"
  value       = aws_route53_zone.default.zone_id
}
