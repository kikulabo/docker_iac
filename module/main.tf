terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.10.0"
      configuration_aliases = [aws.ap-northeast-1]
    }
  }
}

variable domain {
    description = "domain名"
}

resource aws_ses_domain_identity this {
    domain = var.domain
}

resource aws_ses_domain_dkim this {
    domain = aws_ses_domain_identity.this.domain
}