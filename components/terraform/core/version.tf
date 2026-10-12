terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.24.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

#Once we run our terraform init cmd, it will auto generate the lock file
