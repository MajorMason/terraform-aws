#Our modules are in their own individual codeblocks below
module "networking" {
  source                         = "../../modules/networking"
  availability_zone              = var.availability_zone
  availability_zone_secondary    = var.availability_zone_secondary
  vpc_endpoint_security_group_id = module.security.vpc_endpoint_sg_id
  #VPC
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  #Subnets
  public_block            = var.public_block
  private_block           = var.private_block
  private_block_secondary = var.private_block_secondary
}

module "containers" {
  source                  = "../../modules/containers"
  memory                  = var.memory
  cpu                     = var.cpu
  aws_vpc_id              = module.networking.aws_vpc_id
  aws_public_subnet_id    = module.networking.aws_public_subnet_id
  aws_frontend_sg_id      = module.security.frontend_sg_id
  aws_private_subnet_id   = module.networking.aws_private_subnet_id
  aws_backend_sg_id       = module.security.aws_backend_sg_id
  aws_efs_file_storage_id = module.storage.aws_efs_file_storage_id
}

module "database_instance" {
  source               = "../../modules/database"
  allocated_storage    = var.allocated_storage
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  skip_final_snapshot  = var.skip_final_snapshot
  blue_green           = var.blue_green
  db_subnet_group_name = module.networking.db_subnet_group_name
  db_security_group_id = module.security.db_security_group_id
  #Database Backup
  backup_retention_period   = var.backup_retention_period
  backup_window             = var.backup_window
  maintenance_window        = var.maintenance_window
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  deletion_protection       = var.deletion_protection
}

module "security" {
  source     = "../../modules/security"
  aws_vpc_id = module.networking.aws_vpc_id
}

module "storage" {
  source                = "../../modules/storage"
  aws_private_subnet_id = module.networking.aws_private_subnet_id
  efs_security_group_id = module.security.efs_security_group_id
}
