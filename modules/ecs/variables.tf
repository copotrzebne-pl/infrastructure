variable "name" {
  description = "Name used as identifier of created resources."
  type        = string
}

variable "instance_type" {
  description = "The type of the instances to launch."
  type        = string
}

variable "network" {
  description = "Network configuration for ECS cluster."
  type = object({
    assign_instance_public_ips = bool
    subnets                    = list(string)
    security_groups            = list(string)
  })
}

variable "scaling" {
  description = "Scaling configuration of EC2 auto scaling group."
  type = object({
    min_size         = number
    max_size         = number
    desired_capacity = number
  })
}
