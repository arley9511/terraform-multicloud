# project id
variable "project" {
  description = "project name"
  type = string
}

# vpc type
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

# peer type
variable "peers" {
  description = "The peers for the nets in the gcloud project only"
  type = list(object({
    name = string
    net_source = string
    net_destination = string
    destination_project = string
  }))
}

# nat config
variable "nat" {
  description = "The nats gateways for the clusters"
  type = list(object({
    name: string
    router_name = string
    region = string
    network = string
    subnet = list(object({
      name = string
      range = list(string)
    }))
  }))
}
