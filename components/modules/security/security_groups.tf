#Similar to NSGs over on Azure, AWS' security groups will permit or deny traffic
#at the instance level (separate from network level which ACLs provide)
#NOTE: AWS can rely on both Security Groups and ACLs for resource/network security
resource "aws_security_group" "frontend_security_group" {
  vpc_id = var.aws_vpc_id
  name = "frontend_sg"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#We must specify a value of "-1" which denotes "all" and as such, requries
#us to also define a port range of zero to zero, no other ranges are accepted

resource "aws_security_group" "backend_security_group" {
  vpc_id = var.aws_vpc_id
  name = "backend_sg"

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    security_groups = [aws_security_group.frontend_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Using the security group ID reference name, we can allow only the backend security group's
#associated ECS to access the PostgreSQL DB, restricting access appropriately
resource "aws_security_group" "db_security_group" {
  vpc_id = var.aws_vpc_id
  name   = "db_sg"

  ingress {
    description     = "Allow backend ECS to access DB"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_security_group.id]
  }
}

#EFS Security Group to allow only the backend ECS Container
resource "aws_security_group" "efs_security_group" {
  vpc_id  = var.aws_vpc_id
  name    = "efs_sg"

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_security_group.id]
  }
}

#Security Group for the VPC Endpoints (allows inbound HTTPS from our VPC CIDR)
resource "aws_security_group" "vpc_endpoint_security_group" {
  vpc_id      = var.aws_vpc_id
  name        = "vpc_endpoints_sg"

  ingress {
    description = "Access to AWS PrivateLink endpoints from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/20"]
  }
}
