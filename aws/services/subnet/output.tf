output "subnet" {
  value = [for sub in aws_subnet.main: {
    subnet_is = sub.id,
    name = sub.tags.Name
  }]
}

output "elastic_ip" {
  value = [for eip in aws_eip.main: {
    subnet_is = eip.id,
    name = eip.tags.Name
  }]
}

output "nat_gateway" {
  value = [for nat in aws_nat_gateway.main: {
    subnet_is = nat.id,
    name = nat.tags.Name
  }]
}

output "route_table" {
  value = [for rt in aws_route_table.main: {
    subnet_is = rt.id,
    name = rt.tags.Name
  }]
}

output "route_table_association" {
  value = [for rt in aws_route_table_association.main: {
    subnet_is = rt.id
  }]
}
