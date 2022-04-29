variable "domain" {
  description = "Wildcard domain which should be used by Convox (without *)"
  type        = string
}

variable "convox_domain" {
  description = "Domain used by Convox ELB"
  type        = string
}
