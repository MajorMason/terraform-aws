resource "aws_efs_file_system" "efs_storage" {
  creation_token = "app-persistent-data"
  encrypted      = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  tags = {
    environment = var.environment
    }
}
