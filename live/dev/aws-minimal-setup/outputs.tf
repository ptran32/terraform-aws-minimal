output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "public_ip" {
  value = module.bastion.public_ip
}

output "private_ip" {
  value = module.private_vm.private_ip
}

