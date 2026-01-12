resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    name = "${var.environment}"
  }
}

#The cidr_block of 0.0.0.0/0 routes all outbound traffic to the internet gateway
resource "aws_route_table" "public_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    name = "${var.environment}"
  }
}

#Associates the route table with the public subnet in this case
resource "aws_route_table_association" "table_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_table.id
}
