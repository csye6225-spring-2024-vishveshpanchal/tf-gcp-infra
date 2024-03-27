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

# variable "webapp_env_GCP_PROJECT_ID" {
#   type = string
# }

# variable "webapp_env_GCP_PUBSUB_TOPIC_ID" {
#   type = string
# }

variable "pub_sub_topic_name" {
  type = string
}

variable "pub_sub_message_retention_duration" {
  type = string
}

variable "connector_function_cloudsql_name" {
  type = string
}

variable "connector_function_cloudsql_ip_cidr_range" {
  type = string
}

variable "connector_function_cloudsql_region" {
  type = string
}

variable "connector_function_cloudsql_machine_type" {
  type = string
}

variable "connector_function_cloudsql_min_instances" {
  type = string
}

variable "connector_function_cloudsql_max_instances" {
  type = string
}

variable "storage_bucket_function_name" {
  type = string
}

variable "storage_bucket_function_location" {
  type = string
}

variable "storage_bucket_function_force_destroy" {
  type = string
}

variable "storage_bucket_function_storage_class" {
  type = string
}

variable "storage_bucket_function_public_access_prevention" {
  type = string
}

variable "storage_bucket_function_uniform_bucket_level_access" {
  type = string
}

variable "storage_bucket_object_function_name" {
  type = string
}

variable "storage_bucket_object_function_source" {
  type = string
}

variable "send_verification_email_cloud_function_name" {
  type = string
}

variable "cloud_function_MAIL_DOMAIN_NAME" {
  type = string
}

variable "cloud_function_MAILGUN_API_KEY" {
  type = string
}

variable "cloud_function_WEBAPP_DOMAIN_NAME" {
  type = string
}

variable "cloud_function_TOKEN_EXPIRY_TIME_MIN" {
  type = string
}

variable "send_verification_email_cloud_function_google_service_account_account_id" {
  type = string
}

variable "send_verification_email_cloud_function_google_service_account_display_name" {
  type = string
}

variable "google_project_iam_binding_send_verification_email_cloud_function_run_invoker" {
  type = string
}

variable "google_project_iam_binding_send_verification_email_cloud_function_pubsub_subscriber" {
  type = string
}

variable "google_project_iam_binding_pubsub_publisher" {
  type = string
}

variable "send_verification_email_cloud_function_ingress_settings" {
  type = string
}

variable "send_verification_email_cloud_function_event_trigger_event_type" {
  type = string
}

variable "send_verification_email_cloud_function_vpc_connector_egress_settings" {
  type = string
}

variable "send_verification_email_cloud_function_runtime" {
  type = string
}

variable "send_verification_email_cloud_function_available_memory_mb" {
  type = string
}

variable "send_verification_email_cloud_function_location" {
  type = string
}

variable "send_verification_email_cloud_function_entry_point" {
  type = string
}

variable "send_verification_email_cloud_function_max_instance_count" {
  type = string
}

variable "send_verification_email_cloud_function_min_instance_count" {
  type = string
}

variable "send_verification_email_cloud_function_available_memory" {
  type = string
}

variable "send_verification_email_cloud_function_timeout_seconds" {
  type = string
}

variable "send_verification_email_cloud_function_max_instance_request_concurrency" {
  type = string
}

variable "send_verification_email_cloud_function_available_cpu" {
  type = string
}

variable "send_verification_email_cloud_function_trigger_region" {
  type = string
}

variable "send_verification_email_cloud_function_retry_policy" {
  type = string
}