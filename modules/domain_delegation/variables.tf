variable "name" {
  type        = string
  description = "A record name"
}

variable "zone_id" {
  type        = string
  description = "The zone id of the Route53 Hosted Zone"
}

variable "name_servers" {
  type        = list(string)
  default     = []
  description = "A list of name servers"
}
