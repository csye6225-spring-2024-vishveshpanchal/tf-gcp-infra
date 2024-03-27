terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0, < 6.0.0"
    }
  }
}

# Provider
provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

module "vpc" {
  source                               = "./vpc"
  gcp_project                          = var.gcp_project
  gcp_region                           = var.gcp_region
  vpc_network                          = var.vpc_network
  vpc_auto_create_subnetworks          = var.vpc_auto_create_subnetworks
  vpc_routing_mode                     = var.vpc_routing_mode
  vpc_delete_default_routes_on_create  = var.vpc_delete_default_routes_on_create
  subnet_webapp                        = var.subnet_webapp
  subnet_webapp_ip_cidr                = var.subnet_webapp_ip_cidr
  subnet_webapp_route_name             = var.subnet_webapp_route_name
  webapp_route_next_hop_gateway        = var.webapp_route_next_hop_gateway
  subnet_webapp_route                  = var.subnet_webapp_route
  subnet_db                            = var.subnet_db
  subnet_db_ip_cidr                    = var.subnet_db_ip_cidr
  subnet_webapp_firewall_name          = var.subnet_webapp_firewall_name
  subnet_webapp_firewall_protocol      = var.subnet_webapp_firewall_protocol
  subnet_webapp_firewall_ports         = var.subnet_webapp_firewall_ports
  subnet_webapp_firewall_direction     = var.subnet_webapp_firewall_direction
  subnet_webapp_firewall_target_tags   = var.subnet_webapp_firewall_target_tags
  subnet_webapp_firewall_source_ranges = var.subnet_webapp_firewall_source_ranges
  allow_db_firewall                    = var.allow_db_firewall
  allow_db_protocol                    = var.allow_db_protocol
  allow_db_ports                       = var.allow_db_ports
  allow_db_direction                   = var.allow_db_direction
  block_ingress_firewall               = var.block_ingress_firewall
  block_ingress_protocol               = var.block_ingress_protocol
  block_ingress_priority               = var.block_ingress_priority
  block_ingress_direction              = var.block_ingress_direction
  block_ingress_source_ranges          = var.block_ingress_source_ranges
  block_egress_firewall                = var.block_egress_firewall
  block_egress_protocol                = var.block_egress_protocol
  block_egress_priority                = var.block_egress_priority
  block_egress_direction               = var.block_egress_direction
}

module "vm" {
  source                         = "./vm"
  vm_name                        = var.vm_name
  vm_machine_type                = var.vm_machine_type
  vm_zone                        = var.vm_zone
  vm_boot_disk_image             = var.vm_boot_disk_image
  vm_subnetwork                  = module.vpc.vpc_subnetworks_webapp_name
  vm_boot_disk_size              = var.vm_boot_disk_size
  vm_boot_disk_type              = var.vm_boot_disk_type
  vm_tags                        = module.vpc.vpc_subnetworks_webapp_firewall_tags
  vm_stack_type                  = var.vm_stack_type
  vm_network_tier                = var.vm_network_tier
  vm_boot_disk_auto_delete       = var.vm_boot_disk_auto_delete
  webapp_env_NODE_ENV            = var.webapp_env_NODE_ENV
  webapp_env_PORT                = var.webapp_env_PORT
  webapp_env_DB_PORT_PROD        = var.webapp_env_DB_PORT_PROD
  webapp_env_DB_USERNAME_PROD    = module.cloud_sql.webapp_env_DB_USERNAME_PROD
  webapp_env_DB_PASSWORD_PROD    = module.cloud_sql.webapp_env_DB_PASSWORD_PROD
  webapp_env_DB_NAME_PROD        = module.cloud_sql.webapp_env_DB_NAME_PROD
  webapp_env_DB_HOST_PROD        = module.cloud_sql.webapp_env_DB_HOST_PROD
  service_account_email          = module.logging.service_account_email
  service_account_scopes         = var.service_account_scopes
  webapp_env_GCP_PROJECT_ID      = var.gcp_project
  webapp_env_GCP_PUBSUB_TOPIC_ID = module.pubsub.pubsub_topic_verify_email
}

module "cloud_sql" {
  source                        = "./cloud_sql"
  sql_db_version                = var.sql_db_version
  sql_tier                      = var.sql_tier
  sql_availability_type         = var.sql_availability_type
  sql_backup_enabled            = var.sql_backup_enabled
  sql_backup_binary_log_enabled = var.sql_backup_binary_log_enabled
  sql_psc_enabled               = var.sql_psc_enabled
  sql_allowed_consumer_projects = var.gcp_project
  sql_ipv4_enabled              = var.sql_ipv4_enabled
  sql_deletion_protection       = var.sql_deletion_protection
  sql_disk_type                 = var.sql_disk_type
  vpc_subnet_db_name            = module.vpc.vpc_subnetworks_db_name
  vpc_network_name              = module.vpc.vpc_network_name
  sql_disk_size                 = var.sql_disk_size
  sql_database_name             = var.sql_database_name
  sql_username                  = var.sql_username
  sql_reserved_address          = var.sql_reserved_address
  sql_address_type              = var.sql_address_type
}

module "dns" {
  source         = "./dns"
  dns_zone_name  = var.dns_zone_name
  a_record_name  = var.a_record_name
  a_record_type  = var.a_record_type
  a_record_ttl   = var.a_record_ttl
  vm_external_ip = module.vm.vm_external_ip
}

module "logging" {
  source                                                   = "./logging"
  gcp_project                                              = var.gcp_project
  google_service_account_account_id                        = var.google_service_account_account_id
  google_service_account_display_name                      = var.google_service_account_display_name
  google_project_iam_binding_logging_admin_role            = var.google_project_iam_binding_logging_admin_role
  google_project_iam_binding_monitoring_metric_writer_role = var.google_project_iam_binding_monitoring_metric_writer_role
  google_project_iam_binding_pubsub_publisher              = var.google_project_iam_binding_pubsub_publisher
}

module "pubsub" {
  source                             = "./pubsub"
  pub_sub_topic_name                 = var.pub_sub_topic_name
  pub_sub_message_retention_duration = var.pub_sub_message_retention_duration
}

module "vpc_connectors" {
  source                                    = "./vpc_connectors"
  connector_function_cloudsql_name          = var.connector_function_cloudsql_name
  connector_function_cloudsql_ip_cidr_range = var.connector_function_cloudsql_ip_cidr_range
  connector_function_cloudsql_region        = var.connector_function_cloudsql_region
  vpc_network_name                          = module.vpc.vpc_network_name
  connector_function_cloudsql_machine_type  = var.connector_function_cloudsql_machine_type
  connector_function_cloudsql_min_instances = var.connector_function_cloudsql_min_instances
  connector_function_cloudsql_max_instances = var.connector_function_cloudsql_max_instances
}

module "cloud_functions" {
  source                                                                              = "./cloud_functions"
  storage_bucket_function_name                                                        = var.storage_bucket_function_name
  storage_bucket_function_location                                                    = var.storage_bucket_function_location
  storage_bucket_function_force_destroy                                               = var.storage_bucket_function_force_destroy
  storage_bucket_function_storage_class                                               = var.storage_bucket_function_storage_class
  storage_bucket_function_public_access_prevention                                    = var.storage_bucket_function_public_access_prevention
  storage_bucket_function_uniform_bucket_level_access                                 = var.storage_bucket_function_uniform_bucket_level_access
  storage_bucket_object_function_name                                                 = var.storage_bucket_object_function_name
  storage_bucket_object_function_source                                               = var.storage_bucket_object_function_source
  send_verification_email_cloud_function_name                                         = var.send_verification_email_cloud_function_name
  pubsub_topic_verify_email                                                           = module.pubsub.pubsub_topic_verify_email
  webapp_env_DB_USERNAME_PROD                                                         = module.cloud_sql.webapp_env_DB_USERNAME_PROD
  webapp_env_DB_PASSWORD_PROD                                                         = module.cloud_sql.webapp_env_DB_PASSWORD_PROD
  webapp_env_DB_NAME_PROD                                                             = module.cloud_sql.webapp_env_DB_NAME_PROD
  webapp_env_DB_HOST_PROD                                                             = module.cloud_sql.webapp_env_DB_HOST_PROD
  webapp_env_DB_PORT_PROD                                                             = var.webapp_env_DB_PORT_PROD
  cloud_function_MAIL_DOMAIN_NAME                                                     = var.cloud_function_MAIL_DOMAIN_NAME
  cloud_function_MAILGUN_API_KEY                                                      = var.cloud_function_MAILGUN_API_KEY
  cloud_function_WEBAPP_DOMAIN_NAME                                                   = var.cloud_function_WEBAPP_DOMAIN_NAME
  cloud_function_TOKEN_EXPIRY_TIME_MIN                                                = var.cloud_function_TOKEN_EXPIRY_TIME_MIN
  webapp_env_PORT                                                                     = var.webapp_env_PORT
  connector_function_cloudsql_name                                                    = module.vpc_connectors.connector_function_cloudsql_name
  send_verification_email_cloud_function_google_service_account_account_id            = var.send_verification_email_cloud_function_google_service_account_account_id
  send_verification_email_cloud_function_google_service_account_display_name          = var.send_verification_email_cloud_function_google_service_account_display_name
  gcp_project                                                                         = var.gcp_project
  google_project_iam_binding_send_verification_email_cloud_function_run_invoker       = var.google_project_iam_binding_send_verification_email_cloud_function_run_invoker
  google_project_iam_binding_send_verification_email_cloud_function_pubsub_subscriber = var.google_project_iam_binding_send_verification_email_cloud_function_pubsub_subscriber
  send_verification_email_cloud_function_ingress_settings                             = var.send_verification_email_cloud_function_ingress_settings
  send_verification_email_cloud_function_event_trigger_event_type                     = var.send_verification_email_cloud_function_event_trigger_event_type
  send_verification_email_cloud_function_vpc_connector_egress_settings                = var.send_verification_email_cloud_function_vpc_connector_egress_settings
  send_verification_email_cloud_function_runtime                                      = var.send_verification_email_cloud_function_runtime
  send_verification_email_cloud_function_available_memory_mb                          = var.send_verification_email_cloud_function_available_memory_mb
  send_verification_email_cloud_function_location                                     = var.send_verification_email_cloud_function_location
  send_verification_email_cloud_function_entry_point                                  = var.send_verification_email_cloud_function_entry_point
  send_verification_email_cloud_function_max_instance_count                           = var.send_verification_email_cloud_function_max_instance_count
  send_verification_email_cloud_function_min_instance_count                           = var.send_verification_email_cloud_function_min_instance_count
  send_verification_email_cloud_function_available_memory                             = var.send_verification_email_cloud_function_available_memory
  send_verification_email_cloud_function_timeout_seconds                              = var.send_verification_email_cloud_function_timeout_seconds
  send_verification_email_cloud_function_max_instance_request_concurrency             = var.send_verification_email_cloud_function_max_instance_request_concurrency
  send_verification_email_cloud_function_available_cpu                                = var.send_verification_email_cloud_function_available_cpu
  send_verification_email_cloud_function_trigger_region                               = var.send_verification_email_cloud_function_trigger_region
  send_verification_email_cloud_function_retry_policy                                 = var.send_verification_email_cloud_function_retry_policy
}