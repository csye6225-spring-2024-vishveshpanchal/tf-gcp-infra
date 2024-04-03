resource "google_compute_region_autoscaler" "autoscaler" {
  name   = var.reg_autoscaler_name
  region = var.reg_autoscaler_region
  target = var.instance_group_manager_id

  autoscaling_policy {
    max_replicas    = var.reg_autoscaler_policy_max_replicas
    min_replicas    = var.reg_autoscaler_policy_min_replicas
    cooldown_period = var.reg_autoscaler_policy_cooldown_period

    cpu_utilization {
      target = var.reg_autoscaler_policy_target
    }
  }
}