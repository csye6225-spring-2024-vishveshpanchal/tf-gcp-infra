variable "webapp_env_NODE_ENV" {
  type = string
}

variable "webapp_env_PORT" {
  type = number
}

variable "webapp_env_DB_PORT_PROD" {
  type = number
}

variable "webapp_env_DB_USERNAME_PROD" {
  type = string
}

variable "webapp_env_DB_PASSWORD_PROD" {
  type = string
}

variable "webapp_env_DB_NAME_PROD" {
  type = string
}

variable "webapp_env_DB_HOST_PROD" {
  type = string
}

variable "webapp_env_GCP_PROJECT_ID" {
  type = string
}

variable "webapp_env_GCP_PUBSUB_TOPIC_ID" {
  type = string
}

variable "instance_template_region" {
  type = string
}

variable "vpc_network_id" {
  type = string
}

variable "vpc_subnetworks_webapp_id" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "service_account_scopes" {
  type = list(string)
}

variable "instance_template_name" {
  type = string
}

variable "instance_template_machine_type" {
  type = string
}

variable "instance_template_disk_auto_delete" {
  type = string
}

variable "instance_template_disk_boot" {
  type = string
}

variable "instance_template_disk_mode" {
  type = string
}

variable "instance_template_disk_source_image" {
  type = string
}

variable "instance_template_disk_disk_type" {
  type = string
}

variable "instance_template_disk_disk_size_gb" {
  type = string
}

variable "instance_template_disk_type" {
  type = string
}

variable "instance_template_network_tier" {
  type = string
}

variable "instance_template_tags" {
  type = list(string)
}

variable "key_vm_self_link" {
  type = string
}

variable "gcp_sa_iam_compute" {
  # type = 
}