variable "name" {
  description = "Name used as identifier of created resources."
  type        = string
}

variable "default_target_group_arn" {
  description = "Target group ARN for default HTTPS listener"
  type        = string
}

variable "certificate_arn" {
  description = "Certificate ARN used by default HTTPS listener"
  type        = string
}

variable "domain_name" {
  type        = string
  description = "A domain name for ALB"

  validation {
    condition     = !can(regex("[A-Z]", var.domain_name))
    error_message = "Domain name must be lower-case."
  }
}

variable "zone_id" {
  type        = string
  description = "ID of the hosted zone where DNS records will be created"
}

variable "network" {
  description = "Network configuration."
  type = object({
    vpc_id          = string
    public_subnets  = list(string)
    private_subnets = list(string)
    security_groups = list(string)
  })
}
