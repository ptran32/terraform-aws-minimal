variable "environment" {
  description = "Environment to deploy"
  type        = string
}

variable "component" {
  description = "component in the infrastructure e.g vpn, app, database"
  type        = string
}

variable "ingress_ports" {
  description = "Ingress ports for security group"
  type        = map
  default = {
    "22" = ["0.0.0.0/0"]
    "80" = ["0.0.0.0/0"]
  }
}

variable "egress_ports" {
  description = "Egress ports for security group"
  default = {
    "22" = ["0.0.0.0/0"]
  }
}

variable "vpc_id" {
  type = string
}

## Dirty method, need to found a proper way to use SG as source
variable "sg_ref" {
  description = "reference another security group as a source"
  type        = list(string)
  default     = null
}
