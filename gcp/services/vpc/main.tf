# VPC

locals {
  VPC = var.VPC
}

resource "google_compute_network" "main" {
  count = length(var.VPC)

  auto_create_subnetworks = false
  name = var.VPC[count.index].name
  routing_mode = var.VPC[count.index].routing_mode
}
