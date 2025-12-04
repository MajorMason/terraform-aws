resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/20"
  instance_tenancy = var.instance_tenancy
  
  tags = {
    name = "${var.environment}"
  }
}
