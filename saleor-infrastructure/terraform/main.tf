module "networking" {
  source = "./modules/networking"

  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  enable_ipv6        = var.enable_ipv6
  availability_zones = var.availability_zones
  cluster_name       = var.cluster_name
}

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.networking.vpc_id
  vpc_cidr     = var.vpc_cidr
  db_username  = var.db_username
}

module "compute" {
  source = "./modules/compute"

  project_name       = var.project_name
  environment        = var.environment
  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  node_instance_type = var.node_instance_type
  node_desired_size  = var.node_desired_size
  node_min_size      = var.node_min_size
  node_max_size      = var.node_max_size
  private_subnet_ids = module.networking.private_subnet_ids
  public_subnet_ids  = module.networking.public_subnet_ids
  eks_sg_id          = module.security.eks_sg_id
}

module "devops_tools" {
  source = "./modules/devops-tools"

  project_name     = var.project_name
  vpc_id           = module.networking.vpc_id
  public_subnet_id = module.networking.public_subnet_ids[0]
  key_name         = var.devops_key_name
  your_ip_cidr     = var.your_ip_cidr
}

module "data" {
  source = "./modules/data"

  project_name       = var.project_name
  environment        = var.environment
  db_instance_class  = var.db_instance_class
  db_name            = var.db_name
  db_username        = var.db_username
  private_subnet_ids = module.networking.private_subnet_ids
  rds_sg_id          = module.security.rds_sg_id
  db_password_secret = module.security.db_password_secret_arn

  depends_on = [module.security]
}