#Similar to our Azure Terraform project, this project will use an ADO
#build pipeline in order to deploy our IaC in a CI/CD fashion
terraform {
  backend "s3" {}
}

#However, this setup is simpler than ever before, because we are using Atmos,
#which offloads much of the environment specifics to our atmos based yaml files here in the project
#which leads to a simpler azure-pipelines.yaml file.