output "aws_vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "aws_public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "aws_private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group.name
}
