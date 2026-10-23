#The "task" lays the blueprint for the container, and specifies things like the image, CPU, memory,
#environment variables and ports. The family name is just a unique name you give the resource
resource "aws_ecs_task_definition" "task" {
    for_each = local.ecs_tasks

    family = each.value.family
    requires_compatibilities = each.value.requires_compatibilities
    network_mode = each.value.network_mode
    cpu = each.value.cpu
    memory = each.value.memory
    execution_role_arn = var.ecs_task_execution_role_arn

    container_definitions = jsonencode([each.value.container_definitions])

    dynamic "volume" {
      for_each = each.value.volume == null ? [] : [each.value.volume]
      content {
        name = volume.value.name
        efs_volume_configuration {
          file_system_id = volume.value.efs_volume_configuration.file_system_id
          transit_encryption = volume.value.efs_volume_configuration.transit_encryption
        }
      }
    }

    tags = {
      environment = var.environment
    }
}
#We are serializing the jsonencode as seen above
