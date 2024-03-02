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
  subnet_webapp_firewall_port          = var.subnet_webapp_firewall_port
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
  source                      = "./vm"
  vm_name                     = var.vm_name
  vm_machine_type             = var.vm_machine_type
  vm_zone                     = var.vm_zone
  vm_boot_disk_image          = var.vm_boot_disk_image
  vm_subnetwork               = module.vpc.vpc_subnetworks_webapp_name
  vm_boot_disk_size           = var.vm_boot_disk_size
  vm_boot_disk_type           = var.vm_boot_disk_type
  vm_tags                     = module.vpc.vpc_subnetworks_webapp_firewall_tags
  vm_stack_type               = var.vm_stack_type
  vm_network_tier             = var.vm_network_tier
  vm_boot_disk_auto_delete    = var.vm_boot_disk_auto_delete
  webapp_env_NODE_ENV         = var.webapp_env_NODE_ENV
  webapp_env_PORT             = var.webapp_env_PORT
  webapp_env_DB_PORT_PROD     = var.webapp_env_DB_PORT_PROD
  webapp_env_DB_USERNAME_PROD = module.cloud_sql.webapp_env_DB_USERNAME_PROD
  webapp_env_DB_PASSWORD_PROD = module.cloud_sql.webapp_env_DB_PASSWORD_PROD
  webapp_env_DB_NAME_PROD     = module.cloud_sql.webapp_env_DB_NAME_PROD
  webapp_env_DB_HOST_PROD     = module.cloud_sql.webapp_env_DB_HOST_PROD
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