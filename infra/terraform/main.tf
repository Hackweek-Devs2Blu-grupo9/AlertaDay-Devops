terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Data source to get the VPC
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Data source to get the subnet
data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }

  vpc_id = data.aws_vpc.selected.id
}

# Data source to get the security group
data "aws_security_group" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.security_group_name]
  }

  vpc_id = data.aws_vpc.selected.id
}

# Data source to get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 Instance
resource "aws_instance" "alertaday" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type              = var.instance_type
  key_name                   = var.key_pair_name
  subnet_id                  = data.aws_subnet.selected.id
  vpc_security_group_ids     = [data.aws_security_group.selected.id]
  associate_public_ip_address = true

  user_data = file("${path.module}/user_data.sh")

  root_block_device {
    volume_size           = 30
    volume_type          = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = var.instance_name
  }
}
