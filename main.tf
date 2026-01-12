#Our modules are in their own individual codeblocks below
module "networking" {
  source               = "./modules/networking"
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  availability_zone    = var.availability_zone
}

module "containers" {
  source = "./modules/containers"
  memory = var.memory
  cpu    = var.cpu
}

module "database_instance" {
  source              = "./modules/database"
  allocated_storage   = var.allocated_storage
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  username            = var.username
  password            = var.password
  skip_final_snapshot = var.skip_final_snapshot
  retention_period    = var.retention_period
  blue_green          = var.blue_green
}

module "security" {
  source = "./modules/security"
}

module "storage" {
  source = "./modules/storage"
}
