# variables for the GCLOUD vpc's

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
