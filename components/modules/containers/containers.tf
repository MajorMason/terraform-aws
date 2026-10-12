#The "task" lays the blueprint for the container, and specifies things like the image, CPU, memory,
#environment variables and ports. The family name is just a unique name you give the resource
resource "aws_ecs_task_definition" "task" {
    for_each = local.ecs_tasks

    family = each.value.family
    requires_compatibilities = each.value.requires_compatibilities
    network_mode = each.value.network_mode
    cpu = each.value.cpu
    memory = each.value.memory

    container_definitions = jsonencode(each.value.container_definitions)

    tags = {
      environment = var.environment
    }
}
#We are serializing the jsonencode as seen above
