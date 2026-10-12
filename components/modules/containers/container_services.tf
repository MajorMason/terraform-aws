#Our ECS Service is just there to load balance the containers as needed and keeps them healthy
#The ECS Service simply leverages Fargate, which does the actual scaling under the hood
#FE ECS Services
resource "aws_ecs_service" "prothonotary_ecs" {
  name            = "${var.environment}-prothonotary-ecs"
  cluster         = aws_ecs_cluster.cluster["fe_ecs_cluster"].id
  task_definition = aws_ecs_task_definition.task["prothonotary_fe"].arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.aws_public_subnet_id]
    security_groups  = [var.aws_frontend_sg_id]
    assign_public_ip = true
  }

  tags = {
    environment = var.environment
  }
}
#For our "cluster" arguments, since we're using a for_each for our ECS Cluster resources themselves, we must
#define the value for each argument using the square brackets to compute the right value

resource "aws_ecs_service" "sheriff_ecs" {
  name            = "${var.environment}-sheriff-ecs"
  cluster         = aws_ecs_cluster.cluster["fe_ecs_cluster"].id
  task_definition = aws_ecs_task_definition.task["sheriff_fe"].arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.aws_public_subnet_id]
    security_groups  = [var.aws_frontend_sg_id]
    assign_public_ip = true
  }

  tags = {
    environment = var.environment
  }
}

#BE ECS Service
resource "aws_ecs_service" "countysuite_api_ecs" {
  name            = "${var.environment}-countysuite-api-ecs"
  cluster         = aws_ecs_cluster.cluster["be_ecs_cluster"].id
  task_definition = aws_ecs_task_definition.task["countysuite_api"].arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.aws_private_subnet_id]
    security_groups  = [var.aws_backend_sg_id]
    assign_public_ip = false
  }

  tags = {
    environment = var.environment
  }
}
