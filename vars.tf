variable "name" {
  description = "The name of the VPC, also used as a prefix for other resouces"
}

variable "cidr" {
  description = "The VPC cidr"
}

variable "tags" {
  type        = map(string)
  description = "Tags you want to apply to the resources that support it (eg. Environment, Project, ...)"
  default     = {}
}

variable "create_private_networks" {
  description = "Whether or not to create private subnets"
  default     = true
}

variable "create_db_networks" {
  description = "Whether or not to create db subnets"
  default     = false
}

variable "create_nat_instance" {
  description = "Whether or not to create and attach a nat instance to private and db subnets"
  default     = true
}

variable "internal_domain" {
  description = "Create a route53 private zone with using the provided domain"
  default     = ""
}

