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
}

module "vm" {
  source             = "./vm"
  vm_name            = var.vm_name
  vm_machine_type    = var.vm_machine_type
  vm_zone            = var.vm_zone
  vm_boot_disk_image = var.vm_boot_disk_image
  vm_subnetwork      = module.vpc.vpc_subnetworks_webapp_name
  vm_boot_disk_size  = var.vm_boot_disk_size
  vm_boot_disk_type  = var.vm_boot_disk_type
  vm_tags            = module.vpc.vpc_subnetworks_webapp_firewall_tags
  vm_stack_type      = var.vm_stack_type
  vm_network_tier    = var.vm_network_tier
}