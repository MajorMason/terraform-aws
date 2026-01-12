#We are using a Relational Database Service (RDS) for our data storage
resource "aws_db_instance" "database" {
    db_name = "${var.environment}-db"
    allocated_storage = var.allocated_storage
    engine = "postgres"
    engine_version = var.engine_version
    instance_class = var.instance_class
    username = var.username
    password = var.password
    license_model = "license-included"
    skip_final_snapshot = var.skip_final_snapshot
    backup_retention_period = var.retention_period
    blue_green_update {
      enabled = var.blue_green
    }

    tags = {
      environment = "${var.environment}"
    }
}
