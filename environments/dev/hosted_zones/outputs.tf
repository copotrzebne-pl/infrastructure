output "zone_id" {
  description = "The Hosted Zone ID"
  value       = module.hosted_zones.zone_id
}

output "zone_name_servers" {
  value       = module.hosted_zones.zone_name_servers
  description = "A list of name servers in associated (or default) delegation set"
}

output "zone_id_en" {
  description = "The Hosted Zone ID"
  value       = module.hosted_zones.zone_id_en
}

output "zone_name_servers_en" {
  value       = module.hosted_zones.zone_name_servers_en
  description = "A list of name servers in associated (or default) delegation set - EN"
}

output "zone_id_ua" {
  description = "The Hosted Zone ID"
  value       = module.hosted_zones.zone_id_ua
}

output "zone_name_servers_ua" {
  value       = module.hosted_zones.zone_name_servers_ua
  description = "A list of name servers in associated (or default) delegation set - UA"
}
