variable "environment" {
  description = "Environment to deploy"
  type        = string
}

variable "component" {
  description = "component in the infrastructure e.g vpn, app, database"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  type        = string

}

variable "public_cidr_block" {
  description = "CIDR block for publics subnets"
  type        = list(string)
}

variable "private_cidr_block" {
  description = "CIDR block for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "Availability zone where we want to deploy the instance"
  type        = list(string)
}
