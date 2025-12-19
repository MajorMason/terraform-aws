#Similar to our Azure Terraform project, this project will use an ADO
#build pipeline in order to deploy our IaC in a CI/CD fashion
terraform {
  backend "s3" {
    bucket = "terraform"
    key    = "tfstate/dev.tfstate"
    region = "us-east-1"

  }
}

#Also similar to our other ADO build pipeline setup, we dont' need to
#specify any information in the backend config here, because its all
#being handled via pipeline variables downstream
