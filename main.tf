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
  # contd. vpc - for assignment 8
  subnet_proxy_only_name                = var.subnet_proxy_only_name
  subnet_proxy_only_ip_cidr_range       = var.subnet_proxy_only_ip_cidr_range
  subnet_proxy_only_purpose             = var.subnet_proxy_only_purpose
  subnet_proxy_only_region              = var.subnet_proxy_only_region
  subnet_proxy_only_role                = var.subnet_proxy_only_role
  fw_allow_health_probes_name           = var.fw_allow_health_probes_name
  fw_allow_health_probes_allow_ports    = var.fw_allow_health_probes_allow_ports
  fw_allow_health_probes_allow_protocol = var.fw_allow_health_probes_allow_protocol
  fw_allow_health_probes_direction      = var.fw_allow_health_probes_direction
  fw_allow_health_probes_priority       = var.fw_allow_health_probes_priority
  fw_allow_health_probes_source_ranges  = var.fw_allow_health_probes_source_ranges
  fw_allow_health_probes_target_tags    = var.subnet_webapp_firewall_target_tags
  fw_allow_proxy_name                   = var.fw_allow_proxy_name
  fw_allow_proxy_ports                  = var.fw_allow_proxy_ports
  fw_allow_proxy_protocol               = var.fw_allow_proxy_protocol
  fw_allow_proxy_direction              = var.fw_allow_proxy_direction
  fw_allow_proxy_allow_priority         = var.fw_allow_proxy_allow_priority
  fw_allow_proxy_target_tags            = var.subnet_webapp_firewall_target_tags
  fw_allow_gfe_name                     = var.fw_allow_gfe_name
  fw_allow_gfe_allow_ports              = var.fw_allow_gfe_allow_ports
  fw_allow_gfe_allow_protocol           = var.fw_allow_gfe_allow_protocol
  fw_allow_gfe_direction                = var.fw_allow_gfe_direction
  fw_allow_gfe_source_ranges            = var.fw_allow_gfe_source_ranges
  fw_allow_gfe_target_tags              = var.subnet_webapp_firewall_target_tags
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
  sql_fw_rule_name              = var.sql_fw_rule_name
  sql_compute_address_name      = var.sql_compute_address_name
  key_cloud_sql_id              = module.key_management.key_cloud_sql_id
  depends_on                    = [module.key_management]
}

module "dns" {
  source        = "./dns"
  dns_zone_name = var.dns_zone_name
  a_record_name = var.a_record_name
  a_record_type = var.a_record_type
  a_record_ttl  = var.a_record_ttl
  # vm_external_ip = module.vm.vm_external_ip
  lb_external_ip_address = module.app_load_balancer.lb_external_ip_address
}

module "logging" {
  source                                                   = "./logging"
  gcp_project                                              = var.gcp_project
  google_service_account_account_id                        = var.google_service_account_account_id
  google_service_account_display_name                      = var.google_service_account_display_name
  google_project_iam_binding_logging_admin_role            = var.google_project_iam_binding_logging_admin_role
  google_project_iam_binding_monitoring_metric_writer_role = var.google_project_iam_binding_monitoring_metric_writer_role
  google_project_iam_binding_pubsub_publisher              = var.google_project_iam_binding_pubsub_publisher
  google_project_iam_binding_keyRings_create_role          = var.google_project_iam_binding_keyRings_create_role
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
  storage_bucket_function_lifecycle_rule_action_type                                  = var.storage_bucket_function_lifecycle_rule_action_type
  storage_bucket_function_lifecycle_rule_action_storage_class                         = var.storage_bucket_function_lifecycle_rule_action_storage_class
  storage_bucket_function_public_access_prevention                                    = var.storage_bucket_function_public_access_prevention
  storage_bucket_function_uniform_bucket_level_access                                 = var.storage_bucket_function_uniform_bucket_level_access
  storage_bucket_object_function_name                                                 = var.storage_bucket_object_function_name
  storage_bucket_object_function_source                                               = var.storage_bucket_object_function_source
  storage_bucket_object_function_storage_class                                        = var.storage_bucket_object_function_storage_class
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
  key_storage_buckets_id                                                              = module.key_management.key_storage_buckets_id
  storage_buckets_iam                                                                 = module.key_management.storage_buckets_iam
}

module "instance_template" {
  source                              = "./instance_template"
  instance_template_region            = var.instance_template_region
  webapp_env_NODE_ENV                 = var.webapp_env_NODE_ENV
  webapp_env_PORT                     = var.webapp_env_PORT
  webapp_env_DB_PORT_PROD             = var.webapp_env_DB_PORT_PROD
  webapp_env_DB_USERNAME_PROD         = module.cloud_sql.webapp_env_DB_USERNAME_PROD
  webapp_env_DB_PASSWORD_PROD         = module.cloud_sql.webapp_env_DB_PASSWORD_PROD
  webapp_env_DB_NAME_PROD             = module.cloud_sql.webapp_env_DB_NAME_PROD
  webapp_env_DB_HOST_PROD             = module.cloud_sql.webapp_env_DB_HOST_PROD
  webapp_env_GCP_PROJECT_ID           = var.gcp_project
  webapp_env_GCP_PUBSUB_TOPIC_ID      = module.pubsub.pubsub_topic_verify_email
  vpc_network_id                      = module.vpc.vpc_network_id
  vpc_subnetworks_webapp_id           = module.vpc.vpc_subnetworks_webapp_id
  service_account_email               = module.logging.service_account_email
  service_account_scopes              = var.service_account_scopes
  instance_template_name              = var.instance_template_name
  instance_template_machine_type      = var.instance_template_machine_type
  instance_template_disk_auto_delete  = var.instance_template_disk_auto_delete
  instance_template_disk_boot         = var.instance_template_disk_boot
  instance_template_disk_mode         = var.instance_template_disk_mode
  instance_template_disk_source_image = var.instance_template_disk_source_image
  instance_template_disk_disk_type    = var.instance_template_disk_disk_type
  instance_template_disk_disk_size_gb = var.instance_template_disk_disk_size_gb
  instance_template_disk_type         = var.instance_template_disk_type
  instance_template_network_tier      = var.instance_template_network_tier
  instance_template_tags              = var.subnet_webapp_firewall_target_tags
  key_vm_self_link                    = module.key_management.key_vm_self_link
  gcp_sa_iam_compute                  = module.key_management.gcp_sa_iam_compute
}

module "instance_group_manager" {
  source                                                   = "./instance_group_manager"
  instance_template_webapp_id                              = module.instance_template.instance_template_webapp_id
  health_check_id                                          = module.app_load_balancer.health_check_id
  reg_igm_autohealing_initial_delay_sec                    = var.reg_igm_autohealing_initial_delay_sec
  reg_igm_base_instance_name                               = var.reg_igm_base_instance_name
  reg_igm_name                                             = var.reg_igm_name
  reg_igm_named_port_name                                  = var.reg_igm_named_port_name
  reg_igm_named_port_port                                  = var.reg_igm_named_port_port
  reg_igm_region                                           = var.reg_igm_region
  reg_igm_version_name                                     = var.reg_igm_version_name
  reg_igm_update_policy_minimal_action                     = var.reg_igm_update_policy_minimal_action
  reg_igm_update_policy_type                               = var.reg_igm_update_policy_type
  reg_igm_update_policy_max_surge_fixed                    = var.reg_igm_update_policy_max_surge_fixed
  reg_igm_instance_lifecycle_policy_force_update_on_repair = var.reg_igm_instance_lifecycle_policy_force_update_on_repair
}

module "app_load_balancer" {
  source                                = "./app_load_balancer"
  instance_group_manager_instance_group = module.instance_group_manager.instance_group_manager_instance_group
  webapp_ssl_cert                       = module.ssl.webapp_ssl_cert
  webapp_ssl_cert_name                  = module.ssl.webapp_ssl_cert_name
  project                               = var.gcp_project
  global_address_name                   = var.global_address_name
  health_check_name                     = var.health_check_name
  health_check_check_interval_sec       = var.health_check_check_interval_sec
  health_check_healthy_threshold        = var.health_check_healthy_threshold
  health_check_timeout_sec              = var.health_check_timeout_sec
  health_check_unhealthy_threshold      = var.health_check_unhealthy_threshold
  health_check_http_host                = var.health_check_http_host
  health_check_http_port                = var.health_check_http_port
  health_check_http_request_path        = var.health_check_http_request_path
  health_check_log_config_enable        = var.health_check_log_config_enable
  g_fw_rule_ip_protocol                 = var.g_fw_rule_ip_protocol
  g_fw_rule_port_range                  = var.g_fw_rule_port_range
  g_fw_rule_name                        = var.g_fw_rule_name
  g_fw_rule_load_balancing_scheme       = var.g_fw_rule_load_balancing_scheme
  target_https_proxy_name               = var.target_https_proxy_name
  url_map_name                          = var.url_map_name
  bkend_service_backend_balancing_mode  = var.bkend_service_backend_balancing_mode
  bkend_service_backend_capacity_scaler = var.bkend_service_backend_capacity_scaler
  bkend_service_load_balancing_scheme   = var.bkend_service_load_balancing_scheme
  bkend_service_log_config_enable       = var.bkend_service_log_config_enable
  bkend_service_log_config_sample_rate  = var.bkend_service_log_config_sample_rate
  bkend_service_name                    = var.bkend_service_name
  bkend_service_port_name               = var.bkend_service_port_name
  bkend_service_protocol                = var.bkend_service_protocol
  bkend_service_timeout_sec             = var.bkend_service_timeout_sec
  bkend_service_affinity_cookie_ttl_sec = var.bkend_service_affinity_cookie_ttl_sec
  bkend_service_session_affinity        = var.bkend_service_session_affinity
  # # Regional LB and Self managed SSL--------------------------------------------------------------------------
  # instance_group_manager_instance_group = module.instance_group_manager.instance_group_manager_instance_group
  # vpc_network_id                        = module.vpc.vpc_network_id
  # subnet_proxy_only                     = module.vpc.subnet_proxy_only
  # project_id                            = var.gcp_project
  # ssl_certificate_id = module.ssl.ssl_certificate_id
}

module "autoscaler" {
  source                                = "./autoscaler"
  instance_group_manager_id             = module.instance_group_manager.instance_group_manager_id
  reg_autoscaler_region                 = var.reg_autoscaler_region
  reg_autoscaler_policy_target          = var.reg_autoscaler_policy_target
  reg_autoscaler_policy_min_replicas    = var.reg_autoscaler_policy_min_replicas
  reg_autoscaler_policy_max_replicas    = var.reg_autoscaler_policy_max_replicas
  reg_autoscaler_policy_cooldown_period = var.reg_autoscaler_policy_cooldown_period
  reg_autoscaler_name                   = var.reg_autoscaler_name
}

module "ssl" {
  source                  = "./ssl"
  project                 = var.gcp_project
  ssl_certi_name          = var.ssl_certi_name
  ssl_certi_domain_webapp = var.cloud_function_WEBAPP_DOMAIN_NAME
}

module "key_management" {
  source                                          = "./key_management"
  service_account_email                           = module.logging.service_account_email
  keyring_vm_name                                 = var.keyring_vm_name
  keyring_vm_location                             = var.keyring_vm_location
  crypto_key_vm_name                              = var.crypto_key_vm_name
  crypto_key_vm_rotation_period                   = var.crypto_key_vm_rotation_period
  crypto_key_vm_binding_role                      = var.crypto_key_vm_binding_role
  crypto_key_vm_binding_member_1                  = var.crypto_key_vm_binding_member_1
  keyring_cloud_sql_name                          = var.keyring_cloud_sql_name
  keyring_cloud_sql_location                      = var.keyring_cloud_sql_location
  crypto_key_cloud_sql_name                       = var.crypto_key_cloud_sql_name
  crypto_key_cloud_sql_purpose                    = var.crypto_key_cloud_sql_purpose
  gcp_sa_cloud_sql_service                        = var.gcp_sa_cloud_sql_service
  iam_binding_crypto_key_cloud_sql_role           = var.iam_binding_crypto_key_cloud_sql_role
  keyring_storage_buckets_name                    = var.keyring_storage_buckets_name
  keyring_storage_buckets_location                = var.keyring_storage_buckets_location
  crypto_key_storage_buckets_name                 = var.crypto_key_storage_buckets_name
  crypto_key_storage_buckets_rotation_period      = var.crypto_key_storage_buckets_rotation_period
  iam_binding_crypto_key_storage_buckets_role     = var.iam_binding_crypto_key_storage_buckets_role
  iam_binding_crypto_key_storage_buckets_member_1 = var.iam_binding_crypto_key_storage_buckets_member_1
  keyring_cloud_sql_project                       = var.gcp_project
  gcp_sa_cloud_sql_project                        = var.gcp_project
}