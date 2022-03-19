output "azs" {
  description = "A list of used availability zones."
  value       = module.vpc.azs
}

output "vpc_id" {
  description = "Id of the VPC associated to the network."
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets."
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets."
  value       = module.vpc.private_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets."
  value       = module.vpc.database_subnets
}

output "db_subnet_group_name" {
  description = "Name of the subnet group for databases"
  value       = module.vpc.database_subnet_group_name
}

output "default_security_group" {
  value = module.vpc.default_security_group_id
}
