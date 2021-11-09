provider "aws" {
    alias = "ap-northeast-1"
}

provider "aws" {
    alias = "us-west-2"
}

variable domain {
    description = "domain名"
}

resource aws_ses_domain_identity this {
    domain = var.domain
    provider = aws.ap-northeast-1
}

resource aws_ses_domain_dkim this {
    domain = aws_ses_domain_identity.this.domain
    provider = aws.ap-northeast-1
}
