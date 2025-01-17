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

variable "subnet_proxy_only_name" {
  type = string
}

variable "subnet_proxy_only_ip_cidr_range" {
  type = string
}

variable "subnet_proxy_only_purpose" {
  type = string
}

variable "subnet_proxy_only_region" {
  type = string
}

variable "subnet_proxy_only_role" {
  type = string
}

variable "fw_allow_health_probes_name" {
  type = string
}

variable "fw_allow_health_probes_allow_ports" {
  type = list(string)
}

variable "fw_allow_health_probes_allow_protocol" {
  type = string
}

variable "fw_allow_health_probes_direction" {
  type = string
}

variable "fw_allow_health_probes_priority" {
  type = string
}

variable "fw_allow_health_probes_source_ranges" {
  type = list(string)
}

variable "fw_allow_health_probes_target_tags" {
  type = list(string)
}

variable "fw_allow_proxy_name" {
  type = string
}

variable "fw_allow_proxy_ports" {
  type = list(string)
}

variable "fw_allow_proxy_protocol" {
  type = string
}

variable "fw_allow_proxy_direction" {
  type = string
}

variable "fw_allow_proxy_allow_priority" {
  type = string
}

variable "fw_allow_proxy_target_tags" {
  type = list(string)
}

variable "fw_allow_gfe_name" {
  type = string
}

variable "fw_allow_gfe_allow_ports" {
  type = list(string)
}

variable "fw_allow_gfe_allow_protocol" {
  type = string
}

variable "fw_allow_gfe_direction" {
  type = string
}

variable "fw_allow_gfe_source_ranges" {
  type = list(string)
}

variable "fw_allow_gfe_target_tags" {
  type = list(string)
}