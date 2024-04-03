
# Manage a VPC network or legacy network resource on GCP
resource "google_compute_network" "vpc_network" {
  name                            = var.vpc_network
  description                     = "VPC Network for project ${var.gcp_project}"
  auto_create_subnetworks         = var.vpc_auto_create_subnetworks
  routing_mode                    = var.vpc_routing_mode
  delete_default_routes_on_create = var.vpc_delete_default_routes_on_create
}

# Each VPC network is subdivided into subnets. You create instances, containers, and the like in these subnets
# webapp subnet
resource "google_compute_subnetwork" "vpc_subnetworks_webapp" {
  name          = var.subnet_webapp
  ip_cidr_range = var.subnet_webapp_ip_cidr
  network       = google_compute_network.vpc_network.id
  description   = "Subnet: vpc_subnetworks for webapp"
}

# db subnet
resource "google_compute_subnetwork" "vpc_subnetworks_db" {
  name          = var.subnet_db
  ip_cidr_range = var.subnet_db_ip_cidr
  network       = google_compute_network.vpc_network.id
  description   = "Subnet: vpc_subnetworks for db"
}

# Route to 0.0.0.0/0 for the webapp subnet
# !!! is this wrong as the route applies to all of the subnets in the particular network?
resource "google_compute_route" "webapp_route" {
  name             = var.subnet_webapp_route_name
  dest_range       = var.subnet_webapp_route
  network          = google_compute_network.vpc_network.name
  description      = "route to 0.0.0.0/0 for all the webapp subnets"
  next_hop_gateway = var.webapp_route_next_hop_gateway
}

# resource "google_compute_firewall" "webapp_firewall" {
#   name    = var.subnet_webapp_route_name
#   network = google_compute_network.vpc_network.id
#   allow {
#     protocol = var.subnet_webapp_firewall_protocol
#     ports    = var.subnet_webapp_firewall_ports
#   }
#   direction     = var.subnet_webapp_firewall_direction
#   target_tags   = var.subnet_webapp_firewall_target_tags
#   # source_ranges = var.subnet_webapp_firewall_source_ranges
#   source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "10.129.0.0/23"]
# }

resource "google_compute_firewall" "allow_db" {
  name    = var.allow_db_firewall
  network = google_compute_network.vpc_network.id
  allow {
    protocol = var.allow_db_protocol
    ports    = var.allow_db_ports
  }

  direction          = var.allow_db_direction
  target_tags        = var.subnet_webapp_firewall_target_tags
  destination_ranges = [var.subnet_db_ip_cidr]
}

# resource "google_compute_firewall" "block_ingress" {
#   name    = var.block_ingress_firewall
#   network = google_compute_network.vpc_network.id
#   deny {
#     protocol = var.block_ingress_protocol
#   }

#   priority      = var.block_ingress_priority
#   direction     = var.block_ingress_direction
#   source_ranges = var.block_ingress_source_ranges
# }

# resource "google_compute_firewall" "block_egress" {
#   name    = var.block_egress_firewall
#   network = google_compute_network.vpc_network.id
#   deny {
#     protocol = var.block_egress_protocol
#   }

#   priority      = var.block_egress_priority
#   direction     = var.block_egress_direction
#   source_ranges = [var.subnet_webapp_ip_cidr]
# }

resource "google_compute_subnetwork" "proxy_only" {
  name          = var.subnet_proxy_only_name
  ip_cidr_range = var.subnet_proxy_only_ip_cidr_range
  network       = google_compute_network.vpc_network.id
  purpose       = var.subnet_proxy_only_purpose
  region        = var.subnet_proxy_only_region
  role          = var.subnet_proxy_only_role
}

resource "google_compute_firewall" "allow_health_probes" {
  name = var.fw_allow_health_probes_name
  allow {
    ports    = var.fw_allow_health_probes_allow_ports
    protocol = var.fw_allow_health_probes_allow_protocol
  }
  # allow {
  #   ports = ["3000"]
  #   protocol = "tcp"
  # }
  direction     = var.fw_allow_health_probes_direction
  network       = google_compute_network.vpc_network.id
  priority      = var.fw_allow_health_probes_priority
  source_ranges = var.fw_allow_health_probes_source_ranges
  # target_tags   = ["load-balanced-backend"]
  target_tags        = var.fw_allow_health_probes_target_tags
  destination_ranges = [var.subnet_webapp_ip_cidr]
}

resource "google_compute_firewall" "allow_proxy" {
  name = var.fw_allow_proxy_name
  # allow {
  #   ports    = ["443"]
  #   protocol = "tcp"
  # }
  # allow {
  #   ports    = ["80"]
  #   protocol = "tcp"
  # }
  # allow {
  #   ports    = ["8080"]
  #   protocol = "tcp"
  # }
  allow {
    ports    = var.fw_allow_proxy_ports
    protocol = var.fw_allow_proxy_protocol
  }
  direction     = var.fw_allow_proxy_direction
  network       = google_compute_network.vpc_network.id
  priority      = var.fw_allow_proxy_allow_priority
  source_ranges = [google_compute_subnetwork.proxy_only.ip_cidr_range]
  # target_tags   = ["load-balanced-backend"]
  target_tags        = var.fw_allow_proxy_target_tags
  destination_ranges = [var.subnet_webapp_ip_cidr]
}

resource "google_compute_firewall" "block_ingress" {
  name    = var.block_ingress_firewall
  network = google_compute_network.vpc_network.id
  deny {
    protocol = var.block_ingress_protocol
  }

  priority      = var.block_ingress_priority
  direction     = var.block_ingress_direction
  source_ranges = var.block_ingress_source_ranges
}

resource "google_compute_firewall" "allow_gfe" {
  name    = var.fw_allow_gfe_name
  network = google_compute_network.vpc_network.id
  allow {
    protocol = var.fw_allow_gfe_allow_protocol
    ports    = var.fw_allow_gfe_allow_ports
  }
  target_tags        = var.fw_allow_gfe_target_tags
  direction          = var.fw_allow_gfe_direction
  source_ranges      = var.fw_allow_gfe_source_ranges
  destination_ranges = [var.subnet_webapp_ip_cidr]
}