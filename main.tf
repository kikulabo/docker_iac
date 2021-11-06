terraform {
  backend "s3" {
    bucket = "terraform-236614022713"
    key    = "docker_iac.terraform.tfstate.aws"
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
  region = "ap-northeast-1"
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
