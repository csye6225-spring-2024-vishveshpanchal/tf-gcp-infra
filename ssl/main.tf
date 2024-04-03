resource "google_compute_managed_ssl_certificate" "webapp_ssl_cert" {
  provider = google-beta
  project  = var.project
  name     = var.ssl_certi_name

  managed {
    domains = [var.ssl_certi_domain_webapp]
  }
}












# # Self managed SSL certificate--------------------------------------------------------------------------
# resource "google_compute_region_ssl_certificate" "ssl_certificate" {
#   region   = "us-east1"

#   # The name will contain 8 random hex digits,
#   # e.g. "ssl-certificate-48ab27cd2a"
#   name        = random_id.certificate.hex
# #   private_key = file("../webapp-gcp-ssl-key.key")
# #   certificate = file("../sslCertificateFile.crt")
#   private_key = file("webapp-gcp-ssl-key")
#   certificate = file("sslCertificateFile")

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "random_id" "certificate" {
#   byte_length = 4
#   prefix      = "ssl-certificate-"

#   # For security, do not expose raw certificate values in the output
#   keepers = {
#     # private_key = filebase64sha256("../webapp-gcp-ssl-key.key")
#     # certificate = filebase64sha256("../sslCertificateFile.crt")
#     private_key = filebase64sha256("webapp-gcp-ssl-key")
#     certificate = filebase64sha256("sslCertificateFile")
#   }
# }
