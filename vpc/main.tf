
# Manage a VPC network or legacy network resource on GCP
resource "google_compute_network" "vpc_network" {
    count = length(var.vpc_network)
    name = var.vpc_network[count.index]
    description = "VPC Network for project ${var.gcp_project}"
    auto_create_subnetworks = "false"
    routing_mode = "REGIONAL"
    delete_default_routes_on_create = "true"
}

# Each VPC network is subdivided into subnets. You create instances, containers, and the like in these subnets
# webapp subnet
resource "google_compute_subnetwork" "vpc_subnetworks_webapp" {
    count = length(var.subnet_webapp)
    name = var.subnet_webapp[count.index]
    ip_cidr_range = var.subnet_webapp_ip_cidr[count.index]
    network = google_compute_network.vpc_network[count.index].id
    description = "Subnet: vpc_subnetworks for webapp"
    # description = "Subnet: ${google_compute_subnetwork.vpc_subnetworks_webapp.name} within  VPC network: ${google_compute_network.vpc_network.name}"
}

# db subnet
resource "google_compute_subnetwork" "vpc_subnetworks_db" {
    count = length(var.subnet_db)
    name = var.subnet_db[count.index]
    ip_cidr_range = var.subnet_db_ip_cidr[count.index]
    network = google_compute_network.vpc_network[count.index].id
    description = "Subnet: vpc_subnetworks for db"
    # description = "Subnet: ${google_compute_subnetwork.vpc_subnetworks_db.name} within  VPC network: ${google_compute_network.vpc_network.name}"
}

# Route to 0.0.0.0/0 for the webapp subnet
# !!! This is wrong as the route applies to all of the subnets in the particular network!
resource "google_compute_route" "webapp_route" {
    count = length(var.subnet_webapp_route_name)
    name = var.subnet_webapp_route_name[count.index]
    dest_range = var.subnet_webapp_route
    network = google_compute_network.vpc_network[count.index].name
    description = "route to 0.0.0.0/0 for all the webapp subnets"
    next_hop_gateway = "default-internet-gateway"
}