#We are using a Relational Database Service (RDS) for our data storage
resource "aws_db_instance" "database" {
    db_name = "${var.environment}db"
    identifier = "${var.environment}-primary-db"
    allocated_storage = var.allocated_storage
    engine = "postgres"
    engine_version = var.engine_version
    instance_class = var.instance_class
    username = var.username
    password = var.password
    skip_final_snapshot = var.skip_final_snapshot
    db_subnet_group_name   = var.db_subnet_group_name
    vpc_security_group_ids = var.db_security_group_id
    storage_encrypted = true

    backup_retention_period = var.backup_retention_period
    backup_window           = var.backup_window
    maintenance_window      = var.maintenance_window
    copy_tags_to_snapshot   = var.copy_tags_to_snapshot
    final_snapshot_identifier = "${var.environment}-${var.final_snapshot_identifier}"
    deletion_protection       = var.deletion_protection

    blue_green_update {
      enabled = var.blue_green
    }

    tags = {
      environment = var.environment
    }
}
#For our data-plane DB traffic, we don't need any VPC endpoint at all.
#A DB Subnet Group placing the instance in private subnets is sufficient — and all traffic stays on the AWS internal network.
