#We are using an ECS Cluster or "Elastic Container Service" Cluster + ECS Service resource
#This is the equivalent to Azure's Container App Environment resource
resource "aws_ecs_cluster" "ecs_cluster" {
    name = "${var.environment}-ecs-cluster"
}

#Our ECS Service is just there to load balance the containers as needed and keeps them healthy
#The ECS Service simply leverages Fargate, which does the actual scaling under the hood
resource "aws_ecs_service" "ecs_service" {
  name            = "${var.environment}-ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.fe_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_subnet.id]
    security_groups = [aws_security_group.security_group.id]
    assign_public_ip = true
  }
}

#The "task" lays the blueprint for the container, and specifies things like the image, CPU, memory,
#environment variables and ports
#Note: The family name is just a unique name you give the task
resource "aws_ecs_task_definition" "fe_task" {
    family = "${var.environment}-fe-task"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu = var.cpu
    memory = var.memory

    container_definitions = jsonencode([
        {
            name    = "nginx"
            image = "nginx:latest"
            essential = true
            portMappings = [
                {
                    containerPort = 80
                    hostPort = 80
                }
            ]
        }
    ])
}
