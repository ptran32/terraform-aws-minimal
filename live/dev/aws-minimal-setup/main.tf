data "aws_vpc" "selected" {
  id = module.vpc.vpc_id
}

module "vpc" {
  source         = "../../../modules/vpc"
  environment    = "dev"
  component      = "vpc"
  vpc_cidr_block = "10.0.0.0/16"

  azs                = ["us-east-1a", "us-east-1b"]
  public_cidr_block  = ["10.0.10.0/24", "10.0.11.0/24"]
  private_cidr_block = ["10.0.20.0/24", "10.0.21.0/24"]
}

module "bastion_sg" {
  source      = "../../../modules/security-groups"
  environment = "dev"
  component   = "bastion"
  vpc_id      = data.aws_vpc.selected.id
}

module "private_vm_sg" {
  source      = "../../../modules/security-groups"
  environment = "dev"
  component   = "app"
  vpc_id      = data.aws_vpc.selected.id
  sg_ref      = [module.bastion_sg.id]
}

module "bastion" {
  source             = "../../../modules/ec2"
  environment        = "dev"
  component          = "bastion"
  enable_public_ip   = true
  subnet_id          = module.vpc.public_subnet_ids[0]
  vpc_id             = data.aws_vpc.selected.id
  security_group_ids = [module.bastion_sg.id]
  public_key         = var.public_key
}

module "private_vm" {
  source             = "../../../modules/ec2"
  num_instances      = 1
  environment        = "dev"
  component          = "app"
  subnet_id          = module.vpc.private_subnet_ids[0]
  vpc_id             = module.vpc.vpc_id
  security_group_ids = [module.private_vm_sg.id]
  public_key         = var.public_key
}
