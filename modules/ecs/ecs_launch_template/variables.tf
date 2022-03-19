variable "name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "assign_public_ip" {
  type = bool
}
