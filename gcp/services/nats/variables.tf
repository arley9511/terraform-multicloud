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