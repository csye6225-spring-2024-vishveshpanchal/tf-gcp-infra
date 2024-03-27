resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.vm_machine_type
  zone         = var.vm_zone
  tags         = var.vm_tags

  boot_disk {
    auto_delete = var.vm_boot_disk_auto_delete
    device_name = var.vm_name

    initialize_params {
      image = var.vm_boot_disk_image
      size  = var.vm_boot_disk_size
      type  = var.vm_boot_disk_type
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    touch /tmp/.env
    echo "NODE_ENV=${var.webapp_env_NODE_ENV}" >> /tmp/.env
    echo "PORT=${var.webapp_env_PORT}" >> /tmp/.env
    echo "DB_PORT_PROD=${var.webapp_env_DB_PORT_PROD}" >> /tmp/.env
    echo "DB_HOST_PROD=${var.webapp_env_DB_HOST_PROD}" >> /tmp/.env
    echo "DB_USERNAME_PROD=${var.webapp_env_DB_USERNAME_PROD}" >> /tmp/.env
    echo "DB_PASSWORD_PROD=${var.webapp_env_DB_PASSWORD_PROD}" >> /tmp/.env
    echo "DB_NAME_PROD=${var.webapp_env_DB_NAME_PROD}" >> /tmp/.env
    echo "GCP_PROJECT_ID=${var.webapp_env_GCP_PROJECT_ID}" >> /tmp/.env
    echo "GCP_PUBSUB_TOPIC_ID=${var.webapp_env_GCP_PUBSUB_TOPIC_ID}" >> /tmp/.env
    mv /tmp/.env /opt/csye6225/app/.env
    chown -R csye6225:csye6225 /opt/csye6225/app
    sudo systemctl start csye6225.service
  EOT
  # chmod -R 764 /opt/csye6225/app
  # metadata = {
  #   startup-script = <<-EOT
  #     #!/bin/bash
  #     set -e
  #     touch /tmp/.env
  #     echo "NODE_ENV=${var.webapp_env_NODE_ENV}" >> /tmp/.env
  #     echo "PORT=${var.webapp_env_PORT}" >> /tmp/.env
  #     echo "DB_PORT_PROD=${var.webapp_env_DB_PORT_PROD}" >> /tmp/.env
  #     echo "DB_HOST_PROD=${var.webapp_env_DB_HOST_PROD}" >> /tmp/.env
  #     echo "DB_USERNAME_PROD=${var.webapp_env_DB_USERNAME_PROD}" >> /tmp/.env
  #     echo "DB_PASSWORD_PROD=${var.webapp_env_DB_PASSWORD_PROD}" >> /tmp/.env
  #     echo "DB_NAME_PROD=${var.webapp_env_DB_NAME_PROD}" >> /tmp/.env
  #     mv /tmp/.env /home/csye6225/app/.env
  #     chown -R csye6225:csye6225 /home/csye6225/app
  #     chmod -R 764 /home/csye6225/app
  #   EOT
  # }

  network_interface {
    access_config {
      network_tier = var.vm_network_tier
    }

    subnetwork = var.vm_subnetwork
    stack_type = var.vm_stack_type
  }

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }
  allow_stopping_for_update = true
}
