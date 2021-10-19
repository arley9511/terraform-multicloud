locals {
  VPC = flatten([
    for vpc in var.VPC: [
      for subnet in vpc.subnets: {
          network_name = vpc.name

          region = subnet.region
          cidr_range = subnet.range
          sir = subnet.secondary_range
          subnetwork_name = subnet.subnet_name
        }
    ]
  ])
}

resource "google_compute_subnetwork" "main" {
  for_each = {
    for item in local.VPC: item.subnetwork_name => item
  }

  private_ip_google_access = true

  region = each.value.region
  network = each.value.network_name
  name = each.value.subnetwork_name
  ip_cidr_range = each.value.cidr_range

  dynamic "secondary_ip_range" {
    for_each = each.value.sir
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }

}
