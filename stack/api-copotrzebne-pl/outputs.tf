output "iam_policy_arn" {
  value       = aws_iam_policy.default.arn
  description = "Policy ARN."
}
