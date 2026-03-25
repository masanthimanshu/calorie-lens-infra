terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    encrypt        = true
    region         = "ap-south-1"
    key            = "terraform.tfstate"
    bucket         = "calorie-lens-tf-state-bucket"
    dynamodb_table = "calorie-lens-tf-state-lock-table"
  }
}

provider "aws" { profile = var.aws_profile }

module "storage" {
  source       = "./modules/storage"
  project_name = var.project_name
}
