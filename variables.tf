#Our global variables live here, and are necessary so that our modules can tie back to their
#assigned valued in our environments folder
variable "environment" {
  type    = string
  default = "dev"
}

#Networking (Including VPC, Routing, and Subnets)
variable "availability_zone" {
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

#Containers
variable "cpu" {
  type = number
}
variable "memory" {
  type = number
}

#Database Instances
variable "allocated_storage" {
  type = number
}
variable "engine_version" {
  type = string
}
variable "instance_class" {
  type = string
}
variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "skip_final_snapshot" {
  type = bool
}
