output "id" {
  value       = aws_acm_certificate.default.id
  description = "The ID of the certificate"
}

output "arn" {
  value       = aws_acm_certificate.default.arn
  description = "The ARN of the certificate"
}
