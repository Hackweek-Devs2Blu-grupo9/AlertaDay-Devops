variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name of the VPC to use"
  type        = string
  default     = "vpc-modulo9"
}

variable "subnet_name" {
  description = "Name of the subnet to use"
  type        = string
  default     = "sn-rafael"
}

variable "security_group_name" {
  description = "Name of the security group to use"
  type        = string
  default     = "secgroup-AlertaDay"
}

variable "key_pair_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "rafael-pair"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "alertaDay-ec2"
}
