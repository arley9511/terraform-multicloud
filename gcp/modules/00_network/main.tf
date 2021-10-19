# Network Module

locals {
  nat = var.nat
  VPC = var.VPC
  peer = var.peers
  project = var.project
}

# creation of the gcloud vpc's
module "vpc" {
  source = "../../services/vpc"

  # Variables
  VPC = local.VPC
}

# creation of the gcloud subnetworks
module "subnetworks" {
  source = "../../services/subnet"

  depends_on = [module.vpc]

  VPC = local.VPC
}

# creation of the peers
module "peers" {
  source = "../../services/peers"

  depends_on = [module.subnetworks]

  peers = local.peer
  project = local.project
}

# creation of the nat's gateways
module "nat" {
  source = "../../services/nats"

  depends_on = [module.subnetworks]

  nat = var.nat
}
