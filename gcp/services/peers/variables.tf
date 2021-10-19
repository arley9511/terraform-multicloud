variable "peers" {
  description = "The peers for the nets in the gcloud project only"
  type = list(object({
    name = string
    net_source = string
    net_destination = string
    destination_project = string
  }))
}

variable "project" {
  description = "project name"
  type = string
}
