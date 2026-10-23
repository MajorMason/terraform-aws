#The map key names "fe_ecs_cluster" and "be_ecs_cluster" each help
#to fill in the reference name for the resource codeblock itself
locals {
  container_clusters = {
    fe_ecs_cluster = {
        name = "${var.environment}-fe-ecs-cluster"
    }

    be_ecs_cluster = {
        name = "${var.environment}-be-ecs-cluster"
    }
  }
}

#These local values below help to form our three separate ECS container tasks
locals {
  ecs_tasks = {
    prothonotary_fe = {
      family = "${var.environment}-prothonotary-fe"
      requires_compatibilities = ["FARGATE"]
      network_mode = "awsvpc"
      cpu = var.cpu
      memory = var.memory

      container_definitions = {
        name = "prothonotary_fe"
        image = "majormason/mysite:prothonotary_fe"
        essential = true
        portMappings = [
          {
            containerPort = 80
            hostPort = 80
          }
        ]
      }
    }

    sheriff_fe = {
      family = "${var.environment}-sheriff-fe"
      requires_compatibilities = ["FARGATE"]
      network_mode = "awsvpc"
      cpu = var.cpu
      memory = var.memory

      container_definitions = {
        name = "sheriff_fe"
        image = "majormason/mysite:sheriff_fe"
        essential = true
        portMappings = [
          {
            containerPort = 8080
            hostPort = 8080
          }
        ]
      }
    }
    
    countysuite_api = {
      family = "${var.environment}-countysuite-api"
      requires_compatibilities = ["FARGATE"]
      network_mode = "awsvpc"
      cpu = var.cpu
      memory = var.memory
      #We only need persistent storage for the API, the frontends do not need it
      #(alternatively, the FEs can use ephemeral_storage which is AWS native provided storage for temp things)
      volume = {
        name = "efs_storage"
     
        efs_volume_configuration = {
          file_system_id     = var.aws_efs_file_storage_id
          transit_encryption = "ENABLED"
        }
      }
      container_definitions = {
        name = "countysuite_api"
        image = "majormason/mysite:countysuite_api"
        essential = true
        portMappings = [
          {
            containerPort = 8000
            hostPort = 8000
          }
        ]
        mountPoints = [
          {
            sourceVolume  = "efs_storage"
            containerPath = "/app/data"
            readOnly      = false
          }
        ]
        logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_logs.name
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
      }
    }
  }
}
