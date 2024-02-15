terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>5.0"
    }
  }
}

# Provider
provider "google" {
    project = var.gcp_project
    region = var.gcp_region
}

module "vpc" {
  source = "./vpcWRONG"
  gcp_project = var.gcp_project
  gcp_region = var.gcp_region
  vpc_network = var.vpc_network
  subnet_webapp = var.subnet_webapp
  subnet_webapp_ip_cidr = var.subnet_webapp_ip_cidr
  subnet_webapp_route_name = var.subnet_webapp_route_name
  subnet_webapp_route = var.subnet_webapp_route
  subnet_db = var.subnet_db
  subnet_db_ip_cidr = var.subnet_db_ip_cidr
}