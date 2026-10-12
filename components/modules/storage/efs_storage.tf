resource "aws_efs_file_system" "efs_storage" {
  creation_token = "app-persistent-data"
  encrypted      = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  tags = {
    environment = var.environment
    }
}

#The "for_each" does not require a locals.tf file all the time
resource "aws_efs_mount_target" "efs_mount_target" {
  file_system_id  = aws_efs_file_system.efs_storage.id
  subnet_id       = var.aws_private_subnet_id
  security_groups = [var.efs_security_group_id]
}
