# Amazon EC2 Bastion Instance Terraform module

Terraform module which creates EC2 Bastion resources on AWS.

These types of resources are supported:

* [EC2 Instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
* [EIP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)
* [EIP association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association)
* [SecurityGroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
* [Network Interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface)


## Usage
### Create EC2 (Bastion) Instance

main.tf
```hcl
module "bastion" {
  source = "git@github.com:jangjaelee/terraform-aws-bastion.git"

  vpc_name = local.vpc_name 
  key_name = local.vpc_name
  
  #ami-id        = "ami-0e4214f08b51e23cc" // CentOS Linux 7 / 7.9.2009 / ap-northeast-2 / X86_64
  ami-id        = "ami-0e4a9ad2eb120e054" // Amazon Linux 2 AMI (HVM) / ap-northeast-2 / X86_64
  instance-type = "t2.medium" 
  volume_type   = "gp2"
  volume_size   = 8

  az_zone_names = ["ap-northeast-2a"]

  bastion-ingress-sg-rule = ["0.0.0.0/0"]
  bastion-egress-sg-rule  = ["0.0.0.0/0"]

  #kms_arn_ebs = "arn:aws:kms:ap-northeast-2:00000000000:key/ecd396bc-d17a-437a-bcc0-de0a595dca26"

  private_sub_env1 = "1"
  private_sub_env2 = "2"
  public_sub_env1  = "1"
  public_sub_env2  = "2"

  env = "dev"
}
```

locals.tf
```hcl
locals {
  vpc_name = "KubeSphere-dev"
  cluster_name = "KubeSphere-v121-dev"
  cluster_version = "1.21"
}
```

providers.tf
```hcl
provider "aws" {
  version = ">= 3.2.0"
  region = var.region
  allowed_account_ids = var.account_id
  profile = "eks_service"
}
```

terraform.tf
```hcl
terraform {
  required_version = ">= 0.13.0"

  backend "s3" {
    bucket = "kubesphere-terraform-state-backend"
    key = "kubesphere/bastion/terraform.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "kubesphere-terraform-state-locks"
    encrypt = true
    profile = "eks_service"
  }
}
```

variables.tf
```hcl
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "account_id" {
  description = "List of Allowed AWS account IDs"
  type        = list(string)
  default     = ["123456789012"]
}
```
