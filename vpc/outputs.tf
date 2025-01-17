output "vpc_subnetworks_webapp_name" {
  value = google_compute_subnetwork.vpc_subnetworks_webapp.name
}

output "vpc_subnetworks_db_name" {
  value = google_compute_subnetwork.vpc_subnetworks_db.name
}

output "vpc_subnetworks_webapp_id" {
  value = google_compute_subnetwork.vpc_subnetworks_webapp.id
}

output "vpc_subnetworks_webapp_firewall_tags" {
  # value = google_compute_firewall.webapp_firewall.target_tags
  value = ["webapp-firewall"]
}

output "vpc_network_name" {
  value = google_compute_network.vpc_network.name
}

output "vpc_network_id" {
  value = google_compute_network.vpc_network.id
}

# output "subnet_proxy_only" {
#   value = google_compute_subnetwork.proxy_only
# }