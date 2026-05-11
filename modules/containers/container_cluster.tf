#These are the ECS Clusters
#They are the equivalent to Azure's Container App Environment resource
resource "aws_ecs_cluster" "cluster" {
  for_each = local.container_clusters
    
    name = each.value.name

    tags = {
      environment = var.environment
    }
}
#We are using locals + a for_each loop to create both FE and BE clusters
#Note that "each.value" is the defactor standard for referencing any attributes defined in our locals.tf file
#and we're simply pointing to our value of "name" in this case
