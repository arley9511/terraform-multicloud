locals {
  peers = var.peers
  project = var.project
}

resource "google_compute_network_peering" "main" {
  count = length(var.peers)

  name         = local.peers[count.index].name
  network      = "projects/${local.project}/global/networks/${local.peers[count.index].net_source}"
  peer_network = "projects/${local.peers[count.index].destination_project}/global/networks/${local.peers[count.index].net_destination}"

  export_custom_routes = true
  import_custom_routes = true
  import_subnet_routes_with_public_ip = true
  export_subnet_routes_with_public_ip = true
}
