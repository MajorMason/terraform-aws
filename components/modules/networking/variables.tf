variable "environment" {
    type = string
    default = "dev"
}
variable "availability_zone" {
    type = string
}
variable "availability_zone_secondary" {
    type = string
}

#Network
#VPC
variable "cidr_block" {
  type = string
}
variable "instance_tenancy" {
    type = string
}
variable "enable_dns_support" {
    type = bool
}
variable "enable_dns_hostnames" {
    type = bool
}
#Subnet
variable "public_block" {
  type = string
}
variable "private_block" {
  type = string
}
variable "private_block_secondary" {
  type = string
}
#Security
variable "vpc_endpoint_security_group_id" {
  type = string
}
