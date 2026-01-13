resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/20"
  instance_tenancy = var.instance_tenancy
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  
  tags = {
    environment = "${var.environment}"
  }
}
