locals {
  cluster = var.cluster
}

module "gke_clusters" {
  source = "../../services/clusters"

  cluster = local.cluster
}
