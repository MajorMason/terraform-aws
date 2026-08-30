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
    vpc_security_group_ids = var.db_security_group_ids

    backup_retention_period = var.backup_retention_period
    backup_window           = var.backup_window
    maintenance_window      = var.maintenance_window
    copy_tags_to_snapshot   = var.copy_tags_to_snapshot
    final_snapshot_identifier = var.final_snapshot_identifier
    deletion_protection       = var.deletion_protection

    blue_green_update {
      enabled = var.blue_green
    }

    tags = {
      environment = var.environment
    }
}
