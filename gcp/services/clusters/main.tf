locals {
  clusters = flatten([
    for cluster in var.cluster : {
      name = cluster.name
      min_master_ver = cluster.min_master_ver
      network = cluster.network
      subnetwork = cluster.subnetwork
      location = cluster.location
      master_cidr = cluster.master_cidr
      cluster_secondary_range_name = cluster.cluster_secondary_range_name
      services_secondary_range_name = cluster.services_secondary_range_name
      authorized_networks = cluster.authorized_networks
      enable_private_endpoint = cluster.enable_private_endpoint
      enable_private_nodes = cluster.enable_private_nodes
      cluster_autoscaling = cluster.cluster_autoscaling
    }
  ])
  nodes = flatten([
    for cluster in var.cluster : [
      for node in cluster.node_pool : {
        cluster_name = cluster.name
        version = cluster.min_master_ver

        pool_name = node.name
        node_locations = node.node_location
        node_count = node.node_count
        preemptible = node.preemptible
        machine_type = node.machine_type
        disk_type = node.disk_type
        min_cpu_platform = node.min_cpu_platform
        image_type = node.image_type
        disk_size_gb = node.disk_size_gb
      }
    ]
  ])
}

resource "google_container_cluster" "main" {
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  initial_node_count = 1
  remove_default_node_pool = true

  for_each = {
  for item in local.clusters: item.name => item
  }

  name = each.value.name
  min_master_version = each.value.min_master_ver

  location = each.value.location

  network = each.value.network
  subnetwork = each.value.subnetwork

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = each.value.authorized_networks
      content {
        cidr_block = cidr_blocks.value
      }
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name = each.value.cluster_secondary_range_name
    services_secondary_range_name = each.value.services_secondary_range_name
  }

  private_cluster_config {
    enable_private_nodes = each.value.enable_private_nodes
    master_ipv4_cidr_block = each.value.master_cidr
    enable_private_endpoint = each.value.enable_private_endpoint
  }

  cluster_autoscaling {
    enabled = each.value.cluster_autoscaling
  }

}

resource "google_container_node_pool" "main" {
  for_each = {
    for item in local.nodes: "${item.cluster_name}-${item.pool_name}" => item
  }

  depends_on = [google_container_cluster.main]

  name = each.value.pool_name
  node_locations = each.value.node_locations
  cluster = each.value.cluster_name
  node_count = each.value.node_count
  version = each.value.version

  node_config {
    preemptible = each.value.preemptible
    machine_type = each.value.machine_type
    disk_type = each.value.disk_type
    min_cpu_platform = each.value.min_cpu_platform
    image_type = each.value.image_type
    disk_size_gb = each.value.disk_size_gb
    oauth_scopes = [
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management.readonly",
    ]
  }
}
