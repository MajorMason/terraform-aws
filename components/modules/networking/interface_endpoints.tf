#CloudWatch Monitoring Endpoint (Metrics & Alarms)
resource "aws_vpc_endpoint" "cloudwatch_monitoring" {
  vpc_id              = aws_internet_gateway.gateway.vpc_id
  service_name        = "com.amazonaws.${var.availability_zone}.monitoring"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_subnet.subnet_ids]
  security_group_ids  = [var.vpc_endpoint_security_group_id]
  private_dns_enabled = true #Crucial: Keeps SDKs pointing to the normal domain name privately
}

#CloudWatch Logs Endpoint (Log ingestion from ECS tasks)
resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id              = aws_internet_gateway.gateway.vpc_id
  service_name        = "com.amazonaws.${var.availability_zone}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_subnet.subnet_ids]
  security_group_ids  = [var.vpc_endpoint_security_group_id]
  private_dns_enabled = true
}
