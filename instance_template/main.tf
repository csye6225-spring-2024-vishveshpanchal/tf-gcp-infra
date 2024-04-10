resource "random_integer" "get_rand_integer" {
  min = 1
  max = 50000
}

resource "google_compute_region_instance_template" "instance_template_webapp" {
  name         = var.instance_template_name
  region       = var.instance_template_region
  machine_type = var.instance_template_machine_type
  # tags = var.vm_tags
  # tags = ["load-balanced-backend"]
  tags = var.instance_template_tags
  #   tags = "${concat(var.vm_tags, [4])}"
  # tags = concat(tolist(var.vm_tags), tolist(var.allow_health_check_tags))

  #   depends_on = [ google_compute_disk.disk ]
  depends_on = [var.gcp_sa_iam_compute]

  disk {
    # auto_delete = # defaults is true
    # device_name = # If not specified, the server chooses a default device name to apply to this disk
    # disk_name = # When not provided, this defaults to the name of the instance
    # resource_manager_tags = # A set of key/value resource manager tag pairs to bind to this disk
    # labels = # A set of ket/value label pairs to assign to disk created from this template
    # disk_name    = "instance-webapp-disk-${random_integer.get_rand_integer.result}"
    auto_delete  = var.instance_template_disk_auto_delete
    boot         = var.instance_template_disk_boot
    mode         = var.instance_template_disk_mode
    source_image = var.instance_template_disk_source_image
    disk_type    = var.instance_template_disk_disk_type
    disk_size_gb = var.instance_template_disk_disk_size_gb
    type         = var.instance_template_disk_type
    disk_encryption_key {
      kms_key_self_link = var.key_vm_self_link
    }
  }
  # labels = {
  #   managed-by-cnrm = "true"
  # }

  # can_ip_forward = # defaults is false
  # labels = 
  # terraform_labels = 
  # metadata = 
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

  network_interface {
    # network_ip = "192.168.1.5" # private IP address, if not specified it is automatically assigned
    access_config { # IPs via which this instance can be accessed via the Internet
      # nat_ip = If not given, one will be generated
      network_tier = var.instance_template_network_tier
    }
    # network    = var.vpc_network_id
    subnetwork = var.vpc_subnetworks_webapp_id
    # stack_type = "IPV4_ONLY"

  }

  # scheduling {
  #   automatic_restart   = true
  #   on_host_maintenance = "MIGRATE"
  #   provisioning_model  = "STANDARD"
  # }

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }
}