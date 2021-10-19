locals {
  nat = var.nat
}

resource "google_compute_router" "main" {
  count = length(var.nat)

  name = local.nat[count.index].router_name
  region = local.nat[count.index].region
  network = local.nat[count.index].network

  bgp {
    asn = 64514
  }
}

resource "google_compute_address" "main" {
  count = length(var.nat)

  name = "ip-${local.nat[count.index].name}"
  region = local.nat[count.index].region
}

resource "google_compute_router_nat" "main" {
  depends_on = [
    google_compute_router.main,
    google_compute_address.main]

  count = length(var.nat)

  name = local.nat[count.index].name
  region = local.nat[count.index].region
  router = local.nat[count.index].router_name

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = google_compute_address.main[count.index].*.self_link

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  dynamic "subnetwork" {
    for_each = local.nat[count.index].subnet
    content {
      name = subnetwork.value.name
      source_ip_ranges_to_nat = subnetwork.value.range
    }
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
