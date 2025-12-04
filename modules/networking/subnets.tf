resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/20"

  tags = {
    environment = "${var.environment}"
  }
}
