variable "sql_db_version" {
  type = string
}

variable "sql_tier" {
  type = string
}

variable "sql_availability_type" {
  type = string
}

variable "sql_backup_enabled" {
  type = bool
}

variable "sql_backup_binary_log_enabled" {
  type = bool
}

variable "sql_psc_enabled" {
  type = bool
}

variable "sql_allowed_consumer_projects" {
  type = string
}

variable "sql_ipv4_enabled" {
  type = bool
}

variable "sql_deletion_protection" {
  type = bool
}

variable "vpc_subnet_db_name" {
  type = string
}

variable "vpc_network_name" {
  type = string
}

variable "sql_disk_type" {
  type = string
}

variable "sql_disk_size" {
  type = number
}

variable "sql_database_name" {
  type = string
}

variable "sql_username" {
  type = string
}

variable "sql_reserved_address" {
  type = string
}

variable "sql_address_type" {
  type = string
}

variable "sql_fw_rule_name" {
  type = string
}

variable "sql_compute_address_name" {
  type = string
}

variable "key_cloud_sql_id" {
  type = string
}