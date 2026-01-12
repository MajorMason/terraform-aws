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
