output "host" {
  description = "DB Instance host"
  value       = aws_db_instance.default.domain
}

output "port" {
  description = "DB Instance port"
  value       = aws_db_instance.default.port
}
