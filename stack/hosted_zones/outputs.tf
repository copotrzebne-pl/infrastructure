output "zone_id" {
  description = "The Hosted Zone ID"
  value       = module.hosting_zone.zone_id
}

output "zone_name_servers" {
  value       = module.hosting_zone.name_servers
  description = "A list of name servers in associated (or default) delegation set"
}

output "zone_id_en" {
  description = "The Hosted Zone ID"
  value       = module.hosting_zone_en.zone_id
}

output "zone_name_servers_en" {
  value       = module.hosting_zone_en.name_servers
  description = "A list of name servers in associated (or default) delegation set - EN"
}

output "zone_id_ua" {
  description = "The Hosted Zone ID"
  value       = module.hosting_zone_ua.zone_id
}

output "zone_name_servers_ua" {
  value       = module.hosting_zone_ua.name_servers
  description = "A list of name servers in associated (or default) delegation set - UA"
}
