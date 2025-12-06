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
            image   = "nginx:latest"
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

resource "aws_ecs_task_definition" "be_task" {
    family = "${var.environment}-be-task"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu = var.cpu
    memory = var.memory

    container_definitions = jsonencode([
        {
            name    = "fastapi"
            image   = "fastapi:latest"
            essential = true
            portMappings = [
                {
                    containerPort = 8000
                    hostPort = 80
                }
            ]
        }
    ])
}
