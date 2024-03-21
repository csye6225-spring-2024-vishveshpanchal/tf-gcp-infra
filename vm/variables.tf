variable "vm_name" {
  type = string
}

variable "vm_machine_type" {
  type = string
}

variable "vm_zone" {
  type = string
}

variable "vm_tags" {
  type = list(string)
}

variable "vm_boot_disk_image" {
  type = string
}

variable "vm_boot_disk_size" {
  type = string
}

variable "vm_boot_disk_type" {
  type = string
}

variable "vm_network_tier" {
  type = string
}

variable "vm_subnetwork" {
  type = string
}

variable "vm_stack_type" {
  type = string
}

variable "vm_boot_disk_auto_delete" {
  type = bool
}

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

variable "service_account_email" {
  type = string
}

variable "service_account_scopes" {
  type = list(string)
}