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
#NOTE: The "name" value is a specific AWS EC2 API value that must equal "group-name" in this case
data "aws_security_group" "frontend_security_group" {
  filter {
    name   = "group-name"
    values = ["frontend_sg"]
  }
}

data "aws_security_group" "backend_security_group" {
  filter {
    name   = "group-name"
    values = ["backend_sg"]
  }
}
