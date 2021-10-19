module "vpc" {
  source = "../../services/vpc"

  vpc = var.vpc
}

module "subnet" {
  source = "../../services/subnet"

  depends_on = [module.vpc]

  vpc = var.vpc
  gateway_info = module.vpc.gateway_info
  vpc_info = module.vpc.vpc_info
}
