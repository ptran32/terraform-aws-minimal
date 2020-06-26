variable "environment" {
  description = "Environment to deploy"
  type        = string
}

variable "component" {
  description = "component in the infrastructure e.g vpn, app, database"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID. Use to deploy instance into it"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC. Use to deploy VPC into it"
  type        = string

}

variable "enable_public_ip" {
  description = "Associate a public IP to the ec2 instance or not"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "Security group_id(s) to use"
  type        = list(string)
}

variable "instance_type" {
  description = "ec2 instance type to use"
  type        = string
  default     = "t2.micro"
}

variable "public_key" {
  description = "public key to use to connect to ec2 instance"
  type        = string
}

variable "num_instances" {
  description = "number of EC2 instances to deploy"
  type        = string
  default     = 1
}
