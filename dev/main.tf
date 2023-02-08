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
  certificate_arn           = module.certificates.certificate_arn

  depends_on = [
    module.security_group,
    module.vpc,
    module.certificates
  ]
}

module "elasticbeanstalk" {
  source                     = "./modules/elasticbeanstalk"
  env                        = var.env
  project_name               = var.project_name
  private_subnet_cidr_blocks = module.vpc.private_subnet_list
  vpc_id                     = module.vpc.vpc_id
  shared_alb_arn             = module.load_balancer.shared_alb_arn
  shared_alb_sg              = module.security_group.alb_sg
  eb_ec2_sg                  = module.security_group.eb_ec2_sg

  depends_on = [
    module.load_balancer,
    module.vpc,
    module.security_group,
    module.certificates
  ]
}

module "certificates" {
  source                    = "./modules/certificates"
  env                       = var.env
  project_name              = var.project_name
  domain_name               = var.domain_name
  zone_name                 = var.zone_name
  subject_alternative_names = var.subject_alternative_names
}

module "route53" {
  source              = "./modules/route53"
  env                 = var.env
  project_name        = var.project_name
  route53_zone_id     = module.certificates.route53_zone_id
  route53_name        = module.certificates.route53_name
  shared_alb_zone_id  = module.load_balancer.shared_alb_zone_id
  shared_alb_dns_name = module.load_balancer.shared_alb_dns_name
  domains_list         = var.subject_alternative_names
  depends_on = [
    module.load_balancer,
    module.vpc,
    module.security_group,
    module.certificates
  ]
}
