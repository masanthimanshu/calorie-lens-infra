terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    encrypt        = true
    region         = var.aws_region
    key            = "terraform.tfstate"
    bucket         = "calorie-lens-tf-state-bucket"
    dynamodb_table = "calorie-lens-tf-state-lock-table"
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
