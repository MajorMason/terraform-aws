#Our ECS Service is just there to load balance the containers as needed and keeps them healthy
#The ECS Service simply leverages Fargate, which does the actual scaling under the hood
#FE ECS Service
resource "aws_ecs_service" "fe_ecs_service" {
  name            = "${var.environment}-fe-ecs-service"
  cluster         = aws_ecs_cluster.fe_ecs_cluster.id
  task_definition = aws_ecs_task_definition.fe_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_subnet.id]
    security_groups = [aws_security_group.security_group.id]
    assign_public_ip = true
  }
}

#BE ECS Service
resource "aws_ecs_service" "be_ecs_service" {
  name            = "${var.environment}-be-ecs-service"
  cluster         = aws_ecs_cluster.be_ecs_cluster.id
  task_definition = aws_ecs_task_definition.fe_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.private_subnet.id]
    security_groups = [aws_security_group.security_group.id]
    assign_public_ip = false
  }
}
