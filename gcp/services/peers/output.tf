output "config" {
  value = google_compute_network_peering.main[*].*
}