resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.vm_machine_type
  zone         = var.vm_zone
  tags         = var.vm_tags

  boot_disk {
    device_name = var.vm_name

    initialize_params {
      image = var.vm_boot_disk_image
      size  = var.vm_boot_disk_size
      type  = var.vm_boot_disk_type
    }
  }

  network_interface {
    access_config {
      network_tier = var.vm_network_tier
    }

    subnetwork = var.vm_subnetwork
    stack_type = var.vm_stack_type
  }
}
