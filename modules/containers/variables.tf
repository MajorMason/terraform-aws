variable "environment" {
    type = string
    default = "dev"
}

#Container
variable "cpu" {
    type = number
}
variable "memory" {
    type = number
}

#Output Variables
#Network
variable "aws_vpc_id" {
  type = string
}
variable "aws_public_subnet_id" {
  type = string
}
variable "aws_private_subnet_id" {
  type = string
}

#Security
variable "aws_frontend_sg_id" {
  type = string
}
variable "aws_backend_sg_id" {
  type = string
}
