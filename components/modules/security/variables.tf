variable "environment" {
  type = string
}

#Output Variables
#Network
variable "aws_vpc_id" {
  type = string
}
#vpc_cidr variable is set in our atmos env yaml, its not referencing an output-variable in this case
variable "vpc_cidr" {
  type = string
}
