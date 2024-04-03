# reserved IP address
resource "google_compute_global_address" "default" {
  provider = google-beta
  name     = var.global_address_name
  project  = var.project
}

resource "google_compute_health_check" "health_check" {
  name               = var.health_check_name
  project            = var.project
  check_interval_sec = var.health_check_check_interval_sec
  healthy_threshold  = var.health_check_healthy_threshold
  http_health_check {
    host         = var.health_check_http_host
    port         = var.health_check_http_port
    request_path = var.health_check_http_request_path
  }
  timeout_sec         = var.health_check_timeout_sec
  unhealthy_threshold = var.health_check_unhealthy_threshold
  log_config {
    enable = var.health_check_log_config_enable
  }
}

# forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = var.g_fw_rule_name
  project               = var.project
  provider              = google-beta
  ip_protocol           = var.g_fw_rule_ip_protocol
  load_balancing_scheme = var.g_fw_rule_load_balancing_scheme
  port_range            = var.g_fw_rule_port_range
  # target                = google_compute_target_http_proxy.default.id
  target     = google_compute_target_https_proxy.default.id
  ip_address = google_compute_global_address.default.id
  # depends_on = [ google_compute_global_address.default, google_compute_target_http_proxy.default ]
  depends_on = [google_compute_global_address.default, google_compute_target_https_proxy.default]
}

# # http proxy
# resource "google_compute_target_http_proxy" "default" {
#   name     = "lb-target-http-proxy"
#   provider = google-beta
#   url_map  = google_compute_url_map.default.id
#   depends_on = [ google_compute_url_map.default ]
# }

# https proxy
resource "google_compute_target_https_proxy" "default" {
  name             = var.target_https_proxy_name
  project          = var.project
  provider         = google-beta
  url_map          = google_compute_url_map.default.id
  depends_on       = [google_compute_url_map.default, var.webapp_ssl_cert]
  ssl_certificates = [var.webapp_ssl_cert_name]
}

# url map
resource "google_compute_url_map" "default" {
  name            = var.url_map_name
  project         = var.project
  provider        = google-beta
  default_service = google_compute_backend_service.default.id
  depends_on      = [google_compute_backend_service.default]
}

# backend service with custom request and response headers
resource "google_compute_backend_service" "default" {
  name                  = var.bkend_service_name
  project               = var.project
  provider              = google-beta
  protocol              = var.bkend_service_protocol
  port_name             = var.bkend_service_port_name
  load_balancing_scheme = var.bkend_service_load_balancing_scheme
  timeout_sec           = var.bkend_service_timeout_sec
  # enable_cdn              = true
  # custom_request_headers  = ["X-Client-Geo-Location: {client_region_subdivision}, {client_city}"]
  # custom_response_headers = ["X-Cache-Hit: {cdn_cache_status}"]

  # health_checks           = [google_compute_health_check.default.id]
  # depends_on            = [google_compute_health_check.default]
  health_checks = [google_compute_health_check.health_check.id]
  depends_on    = [google_compute_health_check.health_check]
  backend {
    group           = var.instance_group_manager_instance_group
    balancing_mode  = var.bkend_service_backend_balancing_mode
    capacity_scaler = var.bkend_service_backend_capacity_scaler
  }
  log_config {
    enable      = var.bkend_service_log_config_enable
    sample_rate = var.bkend_service_log_config_sample_rate
  }

  # locality_lb_policy    = "ROUND_ROBIN"
  # locality_lb_policies {
  #   policy {
  #     name = "ROUND_ROBIN"
  #   }
  # }
  session_affinity        = var.bkend_service_session_affinity
  affinity_cookie_ttl_sec = var.bkend_service_affinity_cookie_ttl_sec
}






# # Regional LB and Self managed SSL--------------------------------------------------------------------------
# resource "google_compute_address" "lb_external_ip" {
#   name         = "lb-external-ip"
#   address_type = "EXTERNAL"
#   network_tier = "STANDARD"
#   region       = "us-east1"
# }

# resource "google_compute_region_health_check" "lb_health_check" {
#   name               = "lb-health-check"
#   check_interval_sec = 5
#   healthy_threshold  = 2
#   http_health_check {
#     # port_specification = "USE_SERVING_PORT"
#     host = "vishveshpanchal.me"
#     port = 3000
#     # proxy_header       = "NONE"
#     request_path = "/healthz"
#   }
#   region              = "us-east1"
#   timeout_sec         = 5
#   unhealthy_threshold = 2
#   log_config {
#     enable = true
#   }
# }

# resource "google_compute_region_backend_service" "lb_backend_service" {
#   name                  = "lb-backend-service"
#   region                = "us-east1"
#   load_balancing_scheme = "EXTERNAL_MANAGED"
#   health_checks         = [google_compute_region_health_check.lb_health_check.id]
#   depends_on            = [google_compute_region_health_check.lb_health_check]
#   protocol              = "HTTP"
#   session_affinity      = "NONE"
#   timeout_sec           = 30
#   locality_lb_policy    = "ROUND_ROBIN"
#   backend {
#     group           = var.instance_group_manager_instance_group
#     balancing_mode  = "UTILIZATION"
#     capacity_scaler = 1.0
#   }
#   log_config {
#     enable      = true
#     sample_rate = 1
#   }
# }

# # resource "google_compute_url_map" "g_url_map" {
# #   name            = "g-lb-url-map"
# #   # region          = "us-east1"
# #   default_service = google_compute_region_backend_service.lb_backend_service.id
# #   depends_on      = [google_compute_region_backend_service.lb_backend_service]
# # }

# resource "google_compute_region_url_map" "url_map" {
#   name            = "lb-url-map"
#   region          = "us-east1"
#   default_service = google_compute_region_backend_service.lb_backend_service.id
#   depends_on      = [google_compute_region_backend_service.lb_backend_service]
# }

# # resource "google_compute_region_target_http_proxy" "target_http_proxy" {
# #   name       = "lb-target-http-proxy"
# #   region     = "us-east1"
# #   url_map    = google_compute_region_url_map.url_map.id
# #   depends_on = [google_compute_region_url_map.url_map]
# # }

# # For self managed ssl certificate-------------------------------------------------------
# resource "google_compute_region_target_https_proxy" "target_https_proxy" {
#   name       = "lb-target-https-proxy"
#   region     = "us-east1"
#   url_map    = google_compute_region_url_map.url_map.id
#   depends_on = [google_compute_region_url_map.url_map]
#   ssl_certificates = [ var.ssl_certificate_id ]
# }

# resource "google_compute_forwarding_rule" "lb_forwarding_rule" {
#   name     = "lb-forwarding-rule"
#   provider = google-beta
#   # depends_on = [ google_compute_subnetwork.proxy_only ]
#   # depends_on = [google_compute_address.lb_external_ip, google_compute_region_target_http_proxy.target_http_proxy]
#   depends_on = [var.subnet_proxy_only]
#   region     = "us-east1"

#   ip_protocol           = "TCP"
#   load_balancing_scheme = "EXTERNAL_MANAGED"
#   port_range            = "443"
#   # target                = google_compute_region_target_http_proxy.target_http_proxy.id
#   target                = google_compute_region_target_https_proxy.target_https_proxy.id
#   network = var.vpc_network_id
#   # ip_address            = google_compute_address.lb_external_ip.id
#   ip_address   = google_compute_address.lb_external_ip.address
#   network_tier = "STANDARD"
#   project      = var.project_id
# }