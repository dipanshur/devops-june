terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    
  }
  backend "s3" {
    bucket = "tg-devops-june-terraform-state"
    key    = "tfstate/terraform.tfstate"
    region = "us-east-2"
    
  }
}