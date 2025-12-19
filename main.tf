#Our modules are in their own individual codeblocks below
module "networking" {
  source               = "./modules/networking"
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  availability_zone    = var.availability_zone
}
