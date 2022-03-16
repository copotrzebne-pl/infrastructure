variable "subnet_group_name" {
  type        = string
  description = "Name of the subnet group for databases"
}

variable "database_name" {
  type        = string
  description = "Name of the database"
}

variable "db_credentials" {
  type = object({
    username = string
    password = string
  })
  description = "User/password for DB connection"
}
