resource "random_password" "password_generate" {
  length           = 9
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "google_sql_database_instance" "sql_db_instance" {

  database_version = var.sql_db_version
  settings {
    tier              = var.sql_tier
    availability_type = var.sql_availability_type
    disk_type         = var.sql_disk_type
    disk_size         = var.sql_disk_size
    backup_configuration {
      enabled            = var.sql_backup_enabled
      binary_log_enabled = var.sql_backup_binary_log_enabled
    }
    ip_configuration {
      psc_config {
        psc_enabled               = var.sql_psc_enabled
        allowed_consumer_projects = [var.sql_allowed_consumer_projects]
      }
      ipv4_enabled = var.sql_ipv4_enabled
    }
  }
  deletion_protection = var.sql_deletion_protection
}

resource "google_compute_address" "default" {
  #   name = "psc-compute-address-${google_sql_database_instance.sql_db_instance.name}"
  name = "google-compute-address-vap"
  #   region       = "us-central1"
  address_type = var.sql_address_type
  subnetwork   = var.vpc_subnet_db_name   # "default"     # Replace value with the name of the subnet here.
  address      = var.sql_reserved_address # "10.128.0.43" # Replace value with the IP address to reserve.
}

data "google_sql_database_instance" "sql_db_instance" {
  name = google_sql_database_instance.sql_db_instance.name
  # name = resource.google_sql_database_instance.default.name
  depends_on = [ google_sql_database.sql_database ]
}

resource "google_compute_forwarding_rule" "default" {
  #   name                  = "psc-forwarding-rule-${google_sql_database_instance.default.name}"
  #   name = "psc-forwarding-rule-${google_sql_database_instance.sql_db_instance.name}"
  name = "google-compute-forwarding-rule-vap"
  #   region                = "us-central1"
  network               = var.vpc_network_name # "default"
  ip_address            = google_compute_address.default.self_link
  load_balancing_scheme = ""
  target                = data.google_sql_database_instance.sql_db_instance.psc_service_attachment_link
  depends_on = [ google_sql_database.sql_database ]
}

resource "google_sql_database" "sql_database" {
  name     = var.sql_database_name
  instance = google_sql_database_instance.sql_db_instance.name
}

resource "google_sql_user" "sql_users" {
  name     = var.sql_username
  instance = google_sql_database_instance.sql_db_instance.name
  password = random_password.password_generate.result
}