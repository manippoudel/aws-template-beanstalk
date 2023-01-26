module "vpc" {
  source                     = "./modules/vpc"
  vpc_cidr                   = var.vpc_cidr
  env                        = var.env
  project_name               = var.project_name
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones         = var.availability_zones
  region                     = var.region
}

module "security_group" {
  source       = "./modules/security_group"
  env          = var.env
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  depends_on = [
    module.vpc
  ]
}

module "load_balancer" {
  source                    = "./modules/load_balancer"
  env                       = var.env
  project_name              = var.project_name
  public_subnet_cidr_blocks = module.vpc.public_subnet_list
  vpc_id                    = module.vpc.vpc_id
  alb_sg                    = module.security_group.alb_sg
  depends_on = [
    module.security_group,
    module.vpc
  ]
}
