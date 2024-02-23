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

variable "subnet_webapp_firewall_port" {
  type = string
}

variable "subnet_webapp_firewall_direction" {
  type = string
}

variable "subnet_webapp_firewall_target_tags" {
  type = string
}

variable "subnet_webapp_firewall_source_ranges" {
  type = string
}