#The "task" lays the blueprint for the container, and specifies things like the image, CPU, memory,
#environment variables and ports
#Note: The family name is just a unique name you give the task
resource "aws_ecs_task_definition" "prothonotary_fe" {
    family = "${var.environment}-prothonotary-fe"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu = var.cpu
    memory = var.memory

    container_definitions = jsonencode([
        {
            name    = "prothonotary_fe"
            image   = "majormason/mysite:prothonotary_fe"
            essential = true
            portMappings = [
                {
                    containerPort = 80
                    hostPort = 80
                }
            ]
        }
    ])

    tags = {
      environment = "${var.environment}"
    }
}

resource "aws_ecs_task_definition" "sheriff_fe" {
    family = "${var.environment}-sheriff-fe"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu = var.cpu
    memory = var.memory

    container_definitions = jsonencode([
        {
            name    = "sheriff_fe"
            image   = "majormason/mysite:sheriff_fe"
            essential = true
            portMappings = [
                {
                    containerPort = 8080
                    hostPort = 80
                }
            ]
        }
    ])

    tags = {
      environment = "${var.environment}"
    }
}

resource "aws_ecs_task_definition" "countysuite_api" {
    family = "${var.environment}-countysuite-api"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu = var.cpu
    memory = var.memory

    container_definitions = jsonencode([
        {
            name    = "countysuite_api"
            image   = "majormason/mysite:countysuite_api"
            essential = true
            portMappings = [
                {
                    containerPort = 8000
                    hostPort = 80
                }
            ]
        }
    ])

    tags = {
      environment = "${var.environment}"
    }
}
