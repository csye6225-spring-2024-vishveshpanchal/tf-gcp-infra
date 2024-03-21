variable "gcp_project" {
  type = string
}

variable "gcp_region" {
  type = string
}

variable "vpc_network" {
  type = string
}

variable "vpc_auto_create_subnetworks" {
  type = string
}

variable "vpc_routing_mode" {
  type = string
}

variable "vpc_delete_default_routes_on_create" {
  type = string
}

variable "subnet_webapp" {
  type = string
}

variable "subnet_webapp_ip_cidr" {
  type = string
}

variable "subnet_webapp_route_name" {
  type = string
}

variable "webapp_route_next_hop_gateway" {
  type = string
}

variable "subnet_webapp_route" {
  type = string
}

variable "subnet_db" {
  type = string
}

variable "subnet_db_ip_cidr" {
  type = string
}

variable "subnet_webapp_firewall_name" {
  type = string
}

variable "subnet_webapp_firewall_protocol" {
  type = string
}

variable "subnet_webapp_firewall_ports" {
  type = list(string)
}

variable "subnet_webapp_firewall_direction" {
  type = string
}

variable "subnet_webapp_firewall_target_tags" {
  type = list(string)
}

variable "subnet_webapp_firewall_source_ranges" {
  type = list(string)
}

variable "vm_name" {
  type = string
}

variable "vm_machine_type" {
  type = string
}

variable "vm_zone" {
  type = string
}

variable "vm_boot_disk_image" {
  type = string
}

variable "vm_boot_disk_size" {
  type = string
}

variable "vm_boot_disk_type" {
  type = string
}

variable "vm_network_tier" {
  type = string
}

variable "vm_stack_type" {
  type = string
}

variable "vm_boot_disk_auto_delete" {
  type = bool
}

variable "webapp_env_NODE_ENV" {
  type = string
}

variable "webapp_env_PORT" {
  type = number
}

variable "webapp_env_DB_PORT_PROD" {
  type = number
}

variable "sql_db_version" {
  type = string
}

variable "sql_tier" {
  type = string
}

variable "sql_availability_type" {
  type = string
}

variable "sql_backup_enabled" {
  type = bool
}

variable "sql_backup_binary_log_enabled" {
  type = bool
}

variable "sql_psc_enabled" {
  type = bool
}

variable "sql_ipv4_enabled" {
  type = bool
}

variable "sql_deletion_protection" {
  type = bool
}

variable "sql_disk_type" {
  type = string
}

variable "sql_disk_size" {
  type = number
}

variable "sql_database_name" {
  type = string
}

variable "sql_username" {
  type = string
}

variable "sql_reserved_address" {
  type = string
}

variable "sql_address_type" {
  type = string
}

variable "allow_db_firewall" {
  type = string
}

variable "allow_db_protocol" {
  type = string
}

variable "allow_db_ports" {
  type = list(string)
}

variable "allow_db_direction" {
  type = string
}

variable "block_ingress_firewall" {
  type = string
}

variable "block_ingress_protocol" {
  type = string
}

variable "block_ingress_priority" {
  type = number
}

variable "block_ingress_direction" {
  type = string
}

variable "block_ingress_source_ranges" {
  type = list(string)
}

variable "block_egress_firewall" {
  type = string
}

variable "block_egress_protocol" {
  type = string
}

variable "block_egress_priority" {
  type = number
}

variable "block_egress_direction" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "a_record_name" {
  type = string
}

variable "a_record_type" {
  type = string
}

variable "a_record_ttl" {
  type = number
}

variable "google_service_account_account_id" {
  type = string
}

variable "google_service_account_display_name" {
  type = string
}

variable "google_project_iam_binding_logging_admin_role" {
  type = string
}

variable "google_project_iam_binding_monitoring_metric_writer_role" {
  type = string
}

variable "service_account_scopes" {
  type = list(string)
}