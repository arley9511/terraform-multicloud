# cluster configuration variable
variable "cluster" {
  description = "The clusters configuration"
  type = list(object({
    name = string
    min_master_ver = string
    network = string
    subnetwork = string
    location = string
    region = string
    master_cidr = string
    cluster_secondary_range_name = string
    services_secondary_range_name = string
    authorized_networks = list(string)
    enable_private_endpoint = bool
    enable_private_nodes = bool
    cluster_autoscaling = bool
    node_pool = list(object({
      name = string
      node_count = number
      preemptible = bool
      machine_type = string
      disk_type = string
      min_cpu_platform = string
      image_type = string
      disk_size_gb = string
      node_location = list(string)
    }))
  }))
}
