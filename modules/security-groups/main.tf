terraform {
  required_version = ">= 0.12.24"
}

resource "aws_security_group" "this" {
  name        = "${var.environment}-${var.component}-sg"
  description = "security group for ${var.environment}-${var.component}"
  vpc_id      = var.vpc_id

  dynamic ingress {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port       = port.key
      to_port         = port.key
      protocol        = "tcp"
      cidr_blocks     = var.sg_ref == null ? port.value : null
      security_groups = var.sg_ref != "" ? var.sg_ref : null
    }
  }

  dynamic egress {
    iterator = port
    for_each = var.egress_ports
    content {
      from_port   = port.key
      to_port     = port.key
      protocol    = "tcp"
      cidr_blocks = port.value
    }
  }

  tags = {
    Name = "${var.environment}-${var.component}-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

