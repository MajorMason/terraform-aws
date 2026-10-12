#Network
data "aws_vpc" "main_vpc" {
  filter {
    name   = "cidr"
    values = ["10.0.0.0/20"]
  }
}
