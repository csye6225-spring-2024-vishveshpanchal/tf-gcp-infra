output "webapp_ssl_cert_name" {
  value = google_compute_managed_ssl_certificate.webapp_ssl_cert.name
}

output "webapp_ssl_cert" {
  value = google_compute_managed_ssl_certificate.webapp_ssl_cert
}


# # Self managed SSL certificate--------------------------------------------------------------------------
# output "ssl_certificate_id" {
#   value = google_compute_region_ssl_certificate.ssl_certificate.id
# }