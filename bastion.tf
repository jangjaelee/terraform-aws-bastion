data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}-vpc"]
  }
}

data "aws_subnet" "bastion" {
  vpc_id = data.aws_vpc.this.id
  availability_zone = var.az_zone_names[0]

  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}-public-${var.public_sub_env1}-sn"]
  }
}

resource "aws_eip" "bastion" {
  vpc = true

  tags = merge(
    {
      "Name" = format("%s-bastion-eip", var.vpc_name)
    },
    local.common_tags,
  )  
}

resource "aws_eip_association" "bastion" {
  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.bastion.id
}

resource "aws_network_interface" "bastion" {
  description       = "NIC eth0 for ${var.vpc_name}-bastion"
  subnet_id         = data.aws_subnet.bastion.id
  security_groups   = [aws_security_group.bastion.id]

  tags = merge(
    {
      "Name" = format("%s-bastion-nic", var.vpc_name)
    },
    local.common_tags,
  )
}

resource "aws_instance" "bastion" {
  # AMI and Instance Type
  ami           = var.ami-id
  instance_type = var.instance-type

  # SSH connection Key
  key_name      = var.key_name

  # Network Interface
  network_interface {
    network_interface_id = aws_network_interface.bastion.id
    device_index         = 0
  }

  # Storage
  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    encrypted   = true
    kms_key_id  = var.kms_arn_ebs
  }

  credit_specification {
    cpu_credits = "standard"
  }

  tags = merge(
    {
      "Name" = format("%s-bastion", var.vpc_name)
    },
    local.common_tags,
  )
}