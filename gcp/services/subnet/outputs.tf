# Outputs
output "vpc_id" {
  value = google_compute_subnetwork.main[*].*
}
