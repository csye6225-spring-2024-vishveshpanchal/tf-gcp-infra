resource "google_vpc_access_connector" "connector_function_cloudsql" {
  name          = var.connector_function_cloudsql_name
  ip_cidr_range = var.connector_function_cloudsql_ip_cidr_range
  network       = var.vpc_network_name
  region        = var.connector_function_cloudsql_region
  machine_type  = var.connector_function_cloudsql_machine_type
  min_instances = var.connector_function_cloudsql_min_instances
  max_instances = var.connector_function_cloudsql_max_instances
  # min_instances = 2
  # max_instances = 3
  # subnet {

  # }
}