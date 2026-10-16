#This single VPC Endpoint Policy resource codeblock will cover both our CloudWatch Alarm resources in one shot.
#Because all CloudWatch API calls (including metrics and alarms) for that region flow through that single monitoring endpoint,
#the policy acts as a global gatekeeper for that endpoint.
resource "aws_vpc_endpoint_policy" "monitoring_policy" {
  vpc_endpoint_id = aws_vpc_endpoint.cloudwatch_monitoring.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowSpecificRoleOnly"
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "cloudwatch:PutMetricData",
          "cloudwatch:GetMetricData",
          "cloudwatch:DescribeAlarms"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:PrincipalArn" = "arn:aws:iam::123456789012:role/MyECSTaskExecutionRole"
          }
        }
      }
    ]
  })
}
#The reason the FE ECS Task (in addition to the BE Task) can use this resource to direct CloudWatch Alarms (if we had ones setup fo the FE)
#is because all ECS Tasks make an API call to CloudWatch, the VPC's internal DNS resolver maps that request to the private IP addresses of
#our VPC Endpoint ENIs. Remember that ENIs are auto-generated on the fly in the background in AWS