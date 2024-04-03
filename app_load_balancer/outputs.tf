output "lb_external_ip_address" {
  value = google_compute_global_address.default.address
}

output "health_check_id" {
  value = google_compute_health_check.health_check.id
}




# # Regional LB and Self managed SSL--------------------------------------------------------------------------
# output "lb_external_ip_address" {
#   value = google_compute_address.lb_external_ip.address
# }