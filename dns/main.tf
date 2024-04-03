data "google_dns_managed_zone" "csye6225-zone" {
  name = var.dns_zone_name
}

resource "google_dns_record_set" "a_record" {
  name         = var.a_record_name
  managed_zone = data.google_dns_managed_zone.csye6225-zone.name
  type         = var.a_record_type
  ttl          = var.a_record_ttl

  # rrdatas = [var.vm_external_ip]
  rrdatas = [var.lb_external_ip_address]
}

