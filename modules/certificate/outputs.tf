output "id" {
  value       = module.acm_request_certificate.id
  description = "The ID of the certificate"
}

output "arn" {
  value       = module.acm_request_certificate.arn
  description = "The ARN of the certificate"
}
