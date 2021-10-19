output "google_container_cluster" {
  value = google_container_node_pool.main[*].*
}

output "google_container_node_pool" {
  value = google_container_node_pool.main[*].*
}
