terraform {
  required_version = ">= 0.12.24"
}

provider "aws" {
  region = "us-east-1"
}


locals {
  ipv4_all = "0.0.0.0/0"
}


resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.environment}-${var.component}-vpc"
  }
}

resource "aws_subnet" "public" {
  count             = length(var.public_cidr_block)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_cidr_block[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.environment}-${var.component}-subnet-public-${count.index}"
    Tier = "Public"
  }
}

resource "aws_subnet" "private" {
  count      = length(var.private_cidr_block)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_cidr_block[count.index]

  tags = {
    Name = "${var.environment}-${var.component}-subnet-private-${count.index}"
    Tier = "Private"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-${var.component}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = local.ipv4_all
    gateway_id = aws_internet_gateway.igw.id
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.environment}-${var.component}-rt-public"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_cidr_block)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.environment}-${var.component}-gw-nat"
  }
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = local.ipv4_all
    nat_gateway_id = aws_nat_gateway.gw.id
  }
  tags = {
    Name = "${var.environment}-${var.component}-rt-private"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private[0].id
  route_table_id = aws_route_table.private.id
}
