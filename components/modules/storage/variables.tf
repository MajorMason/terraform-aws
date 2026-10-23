variable "environment" {
    type = string
}

#Security
variable "efs_security_group_id" {
  type = string
}

#Network
#Subnet
variable "aws_private_subnet_id" {
  type = string
}
