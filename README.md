# terraform-aws-minimal
Terraform modules to deploy basic VPC with a bastion host and instances

This repo has a set of modules for deployment of network, instances and a bastion host on AWS.
It is only for test purposes, and might not have all requirements for a production setup (e.g network-wise).

# Module VPC
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.24 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azs | Availability zone where we want to deploy the instance | `list(string)` | n/a | yes |
| component | component in the infrastructure e.g vpn, app, database | `string` | n/a | yes |
| environment | Environment to deploy | `string` | n/a | yes |
| private\_cidr\_block | CIDR block for private subnets | `list(string)` | n/a | yes |
| public\_cidr\_block | CIDR block for publics subnets | `list(string)` | n/a | yes |
| vpc\_cidr\_block | CIDR block of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| private\_subnet\_ids | n/a |
| public\_subnet\_ids | n/a |
| vpc\_id | n/a |


# Module EC2
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.24 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component | component in the infrastructure e.g vpn, app, database | `string` | n/a | yes |
| enable\_public\_ip | Associate a public IP to the ec2 instance or not | `bool` | `false` | no |
| environment | Environment to deploy | `string` | n/a | yes |
| instance\_type | ec2 instance type to use | `string` | `"t2.micro"` | no |
| num\_instances | number of EC2 instances to deploy | `string` | `1` | no |
| public\_key | public key to use to connect to ec2 instance | `string` | n/a | yes |
| security\_group\_ids | Security group\_id(s) to use | `list(string)` | n/a | yes |
| subnet\_id | Subnet ID. Use to deploy instance into it | `string` | n/a | yes |
| vpc\_id | ID of the VPC. Use to deploy VPC into it | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| private\_ip | List of private IP addresses assigned to the instances |
| public\_ip | List of public IP assigned to the instances |


# Module security-group
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.24 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component | component in the infrastructure e.g vpn, app, database | `string` | n/a | yes |
| egress\_ports | Egress ports for security group | `map` | <pre>{<br>  "22": [<br>    "0.0.0.0/0"<br>  ]<br>}</pre> | no |
| environment | Environment to deploy | `string` | n/a | yes |
| ingress\_ports | Ingress ports for security group | `map` | <pre>{<br>  "22": [<br>    "0.0.0.0/0"<br>  ],<br>  "80": [<br>    "0.0.0.0/0"<br>  ]<br>}</pre> | no |
| sg\_ref | reference another security group as a source | `list(string)` | `null` | no |
| vpc\_id | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
