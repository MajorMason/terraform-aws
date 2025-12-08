variable "environment" {
    type = string
    default = "dev"
}

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
