terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  // Backend configuration (for tfstate)
  backend "s3" {
    bucket = "tfstate-lookinlabs"
    key    = "hello.tfstate"
    encrypt = true
    region = "eu-west-1"
  }
  required_version = ">= 1.5.1"
}