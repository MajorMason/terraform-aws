#These are the ECS Clusters
#They are the equivalent to Azure's Container App Environment resource
resource "aws_ecs_cluster" "cluster" {
  for_each = local.container_clusters
    
    name = each.value.name

    setting {
      name = "containerInsights"
      value = "enabled"
    }

    tags = {
      environment = var.environment
    }
}
