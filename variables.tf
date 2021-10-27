variable "vpc_name" {
  description = "Name to be used on all the resources as identifier for VPC"
  type        = string
}

variable "ami-id" {
  description = "AMI - Amazon Linux 2"
  type        = string
  #default     = "ami-01af223aa7f274198"
}

variable "instance-type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "volume_size" {
  description = "The size of the volume in gigabytes" 
  type        = number
  default     = 8
}

variable "volume_type" {
  description = "The type of volume. (gp2, io1, io2, standard)"
  type        = string
  default     = "gp2"
}

variable "bastion-ingress-sg-rule" {
  description = "Ingress Security Group rule for Bastion"
  type        = list(string)
  #default     = ["0.0.0.0/0"]
}

variable "bastion-egress-sg-rule" {
  description = "Egress Security Group rule for Bastion"
  type        = list(string)
  #default     = ["0.0.0.0/0"]
}

variable "az_zone_names" {
  description = "Availability Zone"
  type        = list(string)
  #default     = ["ap-northeast-2a","ap-northeast-2c"]
}

variable "key_name" {
  description = "Key Name to use for the bastion host"
  type        = string
}

variable "kms_arn_ebs" {
  description = "KMS ARN for EBS"
  type        = string
  default     = ""
}

variable "private_sub_env1" {
  description = "Private Sub-Environment 1"
  type        = string
  default     = ""
}

variable "public_sub_env1" {
  description = "Public Sub-Environment 1"
  type        = string
  default     = ""
}

variable "private_sub_env2" {
  description = "Private Sub-Environment 2"
  type        = string
  default     = ""
}

variable "public_sub_env2" {
  description = "Public Sub-Environment 2"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "env" {
  description = "Environment"
  type = string
}
