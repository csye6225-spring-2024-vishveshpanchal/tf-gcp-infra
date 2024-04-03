resource "google_compute_region_instance_group_manager" "instance_group_manager" {
  name = var.reg_igm_name
  #   zone = "us-west1-a"
  region = var.reg_igm_region
  #   ORIGINAL
  # named_port {
  #   name = "http"
  #   port = 80
  # }
  named_port {
    name = var.reg_igm_named_port_name
    port = var.reg_igm_named_port_port
  }
  version {
    instance_template = var.instance_template_webapp_id
    name              = var.reg_igm_version_name
  }
  base_instance_name = var.reg_igm_base_instance_name
  auto_healing_policies {
    health_check      = var.health_check_id
    initial_delay_sec = var.reg_igm_autohealing_initial_delay_sec
  }
  # target_size = 2
}

