variable "instance_group_manager_instance_group" {
  type = string
}

variable "webapp_ssl_cert_name" {
  type = string
}

variable "webapp_ssl_cert" {
  # type = 
}

variable "project" {
  type = string
}

variable "global_address_name" {
  type = string
}

variable "health_check_name" {
  type = string
}

variable "health_check_check_interval_sec" {
  type = string
}

variable "health_check_healthy_threshold" {
  type = string
}

variable "health_check_timeout_sec" {
  type = string
}

variable "health_check_unhealthy_threshold" {
  type = string
}

variable "health_check_http_host" {
  type = string
}

variable "health_check_http_port" {
  type = string
}

variable "health_check_http_request_path" {
  type = string
}

variable "health_check_log_config_enable" {
  type = string
}

variable "g_fw_rule_name" {
  type = string
}

variable "g_fw_rule_ip_protocol" {
  type = string
}

variable "g_fw_rule_load_balancing_scheme" {
  type = string
}

variable "g_fw_rule_port_range" {
  type = string
}

variable "target_https_proxy_name" {
  type = string
}

variable "url_map_name" {
  type = string
}

variable "bkend_service_name" {
  type = string
}

variable "bkend_service_protocol" {
  type = string
}

variable "bkend_service_port_name" {
  type = string
}

variable "bkend_service_load_balancing_scheme" {
  type = string
}

variable "bkend_service_timeout_sec" {
  type = string
}

variable "bkend_service_backend_balancing_mode" {
  type = string
}

variable "bkend_service_backend_capacity_scaler" {
  type = string
}

variable "bkend_service_log_config_enable" {
  type = string
}

variable "bkend_service_log_config_sample_rate" {
  type = string
}

variable "bkend_service_session_affinity" {
  type = string
}

variable "bkend_service_affinity_cookie_ttl_sec" {
  type = string
}

# # Regional LB and Self managed SSL--------------------------------------------------------------------------
# variable "instance_group_manager_instance_group" {
#   type = string
# }

# variable "vpc_network_id" {
#   type = string
# }

# variable "subnet_proxy_only" {
#   # type = 
# }

# variable "project_id" {
#   type = string
# }

# variable "ssl_certificate_id" {
#   type = string
# }
