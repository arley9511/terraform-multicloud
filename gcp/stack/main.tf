# Network Module

locals {
  nat = var.nat
  VPC = var.VPC
  peers = var.peers
  cluster = var.cluster
}

module "compute" {
  source = "./../modules/00_compute"

  cluster = local.cluster
}
