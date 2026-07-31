module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = "${var.name_prefix}-vpc"
}
module "networking" {
  source = "./modules/networking"
  vpc_id = module.vpc.vpc_id
  public_subnet_cidr = var.public_subnet_cidr
  name_prefix = var.name_prefix
}
module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  name_prefix = var.name_prefix
}
module "compute" {
  source = "./modules/compute"
  subnet_id = module.networking.public_subnet_id
  security_group_id = module.security_group.security_group_id
  instance_type = var.instance_type
  full_name = var.full_name
  key_name = var.key_name
  name_prefix = var.name_prefix
}