variable "environment" {
    type = string
    default = "dev"
}

#Network
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
