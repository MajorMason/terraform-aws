#Endpoint service names require the region, not an AZ
data "aws_region" "current" {}

#CloudWatch Monitoring Endpoint (Metrics & Alarms)
resource "aws_vpc_endpoint" "cloudwatch_monitoring" {
  vpc_id              = aws_vpc.main_vpc.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.monitoring"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_subnet.id]
  security_group_ids  = [var.vpc_endpoint_security_group_id]
  private_dns_enabled = true #Crucial: Keeps SDKs pointing to the normal domain name privately
}

#CloudWatch Logs Endpoint (Log ingestion from ECS tasks)
resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id              = aws_vpc.main_vpc.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_subnet.id]
  security_group_ids  = [var.vpc_endpoint_security_group_id]
  private_dns_enabled = true
}
