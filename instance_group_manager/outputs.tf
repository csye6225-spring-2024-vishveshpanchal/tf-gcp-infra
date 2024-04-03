output "instance_group_manager_instance_group" {
  value = google_compute_region_instance_group_manager.instance_group_manager.instance_group
}

output "instance_group_manager_id" {
  value = google_compute_region_instance_group_manager.instance_group_manager.id
}

output "igm_target_tags" {
  value = google_compute_region_instance_group_manager.instance_group_manager.distribution_policy_target_shape
}