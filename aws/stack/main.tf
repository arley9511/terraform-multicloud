module "network" {
  source = "./../modules/00_network"

  vpc = var.vpc
}
