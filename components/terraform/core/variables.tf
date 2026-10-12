#Our global variables live here, and are necessary so that our modules can tie back to their
#assigned valued in our environments folder
variable "environment" {
  type    = string
  default = "dev"
}
variable "availability_zone" {
  type = string
}
variable "availability_zone_secondary" {
  type = string
}

#Networking (Including VPC, Routing, and Subnets)
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
#Subnets
variable "public_block" {
  type = string
}
variable "private_block" {
  type = string
}
variable "private_block_secondary" {
  type = string
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
variable "blue_green" {
  type = bool
}
#Database Backups
variable "backup_retention_period" {
  type = number
}
variable "backup_window" {
  type = string
}
variable "maintenance_window" {
  type = string
}
variable "copy_tags_to_snapshot" {
  type = bool
}
variable "final_snapshot_identifier" {
  type = string
}
variable "deletion_protection" {
  type = bool
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
variable "db_subnet_group_name" {
  type = string
}

#Security
variable "aws_frontend_sg_id" {
  type = string
}
variable "aws_backend_sg_id" {
  type = string
}
variable "db_security_group_id" {
  type = list(string)
}
variable "efs_security_group_id" {
  type = string
}

#Storage
variable "aws_efs_file_storage_id" {
  type = string
}
