#ECS Logs is only for log collection, not CPU nor RAM usage which require CloudWatch separately
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.environment}-countysuite-api"
  retention_in_days = 30
}

#SNS is for notification delivery of CloudWatch alarms
resource "aws_sns_topic" "ecs_alerts" {
  name = "${var.environment}-ecs-resource-alerts"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.ecs_alerts.arn
  protocol  = "email"
  endpoint  = "your-email@example.com"
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name          = "${var.environment}-ecs-high-cpu-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This alarm triggers when ECS container CPU usage exceeds 80%"
  alarm_actions       = [aws_sns_topic.ecs_alerts.arn]

  dimensions = {
    ClusterName = aws_ecs_cluster.cluster["be_ecs_cluster"].name
    ServiceName = aws_ecs_service.countysuite_api_ecs.name
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory_high" {
  alarm_name          = "${var.environment}-ecs-high-memory-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This alarm triggers when ECS container Memory usage exceeds 80%"
  alarm_actions       = [aws_sns_topic.ecs_alerts.arn]

  dimensions = {
    ClusterName = aws_ecs_cluster.cluster["be_ecs_cluster"].name
    ServiceName = aws_ecs_service.countysuite_api_ecs.name
  }
}
