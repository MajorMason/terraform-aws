#These are the ECS Clusters or "Elastic Container Service" Clusters
#They are the equivalent to Azure's Container App Environment resource
resource "aws_ecs_cluster" "fe_ecs_cluster" {
    name = "${var.environment}-fe-ecs-cluster"

    tags = {
      environment = "${var.environment}"
    }
}

resource "aws_ecs_cluster" "be_ecs_cluster" {
    name = "${var.environment}-be-ecs-cluster"

    tags = {
      environment = "${var.environment}"
    }
}
