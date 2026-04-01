variable "environment" {
    type = string
    default = "dev"
}

#Database
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
variable "retention_period" {
    type = number
}
variable "blue_green" {
    type = bool
}

#Security Groups
#This is a variable that Terraform provides a value for behind the scenes during runtime
#thanks to our outputs.tf file over in our "security" module
variable "db_security_group_ids" {
  description = "List of security group IDs to attach to the DB instance"
  type        = list(string)
}
