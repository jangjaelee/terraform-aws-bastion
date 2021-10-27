resource "aws_security_group" "bastion" {
  name         = "${var.vpc_name}-bastion-sg"
  description  = "${var.vpc_name} Bastion security group"
  vpc_id       = data.aws_vpc.this.id

  ingress {
    description = "Inbound"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion-ingress-sg-rule
  }

  egress {
    description = "Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.bastion-egress-sg-rule
  }

  tags = merge(
    {
      "Name" = format("%s-bastion-sg", var.vpc_name)
    },
    local.common_tags,
  )    
}

/*
# Security Group Rule - SSH (TCP 22) - Admin for Bastion
resource "aws_security_group_rule" "bastion" {
  description              = "Bastion for Admin"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["221.148.35.240/32","221.150.51.4/32", "13.209.172.51/32"]
  security_group_id        = aws_security_group.bastion.id
}
*/