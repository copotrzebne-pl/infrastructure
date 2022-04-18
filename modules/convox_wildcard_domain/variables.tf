variable "rack_name" {
  type        = string
  description = "Rack name"
}

variable "domain" {
  description = "Wildcard domain which should be used by Convox (without *)"
  type        = string
}
