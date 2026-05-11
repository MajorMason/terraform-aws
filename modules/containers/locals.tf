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
#The map key names "fe_ecs_cluster" and "be_ecs_cluster" each help
#to fill in the reference name for the resource codeblock itself
