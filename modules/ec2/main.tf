terraform {
  required_version = ">= 0.12.24"
}

provider "aws" {
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "this" {
  count                       = var.num_instances
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = var.enable_public_ip
  vpc_security_group_ids      = var.security_group_ids

  tags = {
    Name = "${var.environment}-${var.component}-${format("%02d", count.index + 1)}"
  }
}


resource "aws_key_pair" "deployer" {
  key_name   = "${var.environment}-${var.component}-keypair-deployer"
  public_key = var.public_key
}

