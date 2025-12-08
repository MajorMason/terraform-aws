resource "aws_db_instance" "database" {
    db_name = "${var.environment}-db"
    allocated_storage = var.allocated_storage
    engine = "sqlserver-se"
    engine_version = var.engine_version
    instance_class = var.instance_class
    username = var.username
    password = var.password
    license_model = "license-included"
    skip_final_snapshot = var.skip_final_snapshot

    tags = {
      environment = "${var.environment}"
    }
}
