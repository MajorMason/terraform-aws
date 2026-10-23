resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_block
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone

  tags = {
    environment = var.environment
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.private_block
  availability_zone = var.availability_zone

  tags = {
    environment = var.environment
  }
}

resource "aws_subnet" "private_subnet_secondary" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.private_block_secondary
  availability_zone = var.availability_zone_secondary

  tags = {
    environment = var.environment
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id, aws_subnet.private_subnet_secondary.id]

  tags = {
    environment = var.environment
  }
}
