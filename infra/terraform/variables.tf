variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "ID of the VPC to use"
  type        = string
  default     = "vpc-06786ee7f7a163059"
}

variable "subnet_id" {
  description = "ID of the subnet to use"
  type        = string
  default     = "subnet-0f02b82db8909dfa2"
}

variable "security_group_id" {
  description = "ID of the security group to use"
  type        = string
  default     = "sg-0d93712067c156844"
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
