# Variables Default

variable "project_id" {
  description = "ID Region for Infrastructure deployment"

}

variable "region" {
  description = "ID Region for Infrastructure deployment"
}

variable "zone" {
  description = "ID zone for Infrastructure deployment"

}

variable "VPC" {
  description = "The names for the VPCs of the project"
  type = list(object({
    name = string,
    routing_mode = string,
    subnets = list(object({
      range = string
      region = string,
      subnet_name = string,
      secondary_range = list(object({
        ip_cidr_range = string
        range_name = string
      }))
    }))
  }))
}

variable "peers" {
  description = "The peers for the nets in the gcloud project only"
  type = list(object({
    name = string
    net_source = string
    net_destination = string
    destination_project = string
  }))
}

variable "nat" {
  description = "The nats gateways for the clusters"
  type = list(object({
    name = string
    router_name = string
    region = string
    network = string
    subnet = list(object({
      name = string
      range = list(string)
    }))
  }))
}

variable "cluster" {
  description = "The clusters configuration"
  type = list(object({
    name = string
    min_master_ver = string
    network = string
    subnetwork = string
    region = string
    location = string
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
