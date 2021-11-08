terraform {
  backend "s3" {
    bucket = "terraform-236614022713"
    key    = "versionup.terraform.tfstate.aws"
    region = "ap-northeast-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.10.0"
    }
  }
}

provider "aws" {
  alias = "ap-northeast-1"
  region = "ap-northeast-1"
}

provider "aws" {
  alias = "us-west-2"
  region = "us-west-2"
}

variable "amis" {
  type = map(string)
  default = {
    us-east-1      = "ami-0dc185deadd3ac449"
    us-west-2      = "ami-014612c2d9afaf1ac"
    ap-northeast-1 = "ami-01748a72bed07727c"
  }
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "new-docker_iac_vpc"
  }
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

module "create_ses" {
    source = "./module/"
    domain = "kikulabo.com"
    providers = {
      aws.us-west-2 = aws.us-west-2
      aws.ap-northeast-1 = aws.ap-northeast-1
    }
}