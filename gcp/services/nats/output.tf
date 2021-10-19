output "google_compute_router" {
  value = google_compute_router.main[*].*
}

output "google_compute_router_nat" {
  value = google_compute_router_nat.main[*].*
}
