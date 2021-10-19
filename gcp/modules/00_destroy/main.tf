locals {
  VPC = var.VPC
}

module "destroy_network" {
  source = "../../services/vpc"


  VPC = local.VPC
}
