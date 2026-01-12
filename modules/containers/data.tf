#We must use filter blocks due to AWS' API call style
#Network
data "aws_vpc" "main_vpc" {
  filter {
    name   = "cidr"
    values = ["10.0.0.0/20"]
  }
}

data "aws_subnet" "public_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main_vpc.id]
  }
  filter {
    name   = "cidr-block"
    values = ["10.0.2.0/24"]
  }
}

data "aws_subnet" "private_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main_vpc.id]
  }
  filter {
    name   = "cidr-block"
    values = ["10.0.1.0/24"]
  }
}

#Security
data "aws_security_group" "security_group" {
  filter {
    name   = "group-name"
    values = ["ECS-SG"]
  }
}
