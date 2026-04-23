#This output exposes only the database security group ID to our database module
#and then ultimately allows us to reference the DB security group ID in the database root module codeblock
output "frontend_sg_id" {
  value = aws_security_group.frontend_security_group.id
}

output "backend_sg_id" {
  value = aws_security_group.backend_security_group.id
}

output "db_security_group_id" {
  value = aws_security_group.db_security_group.id
}
