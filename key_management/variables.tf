variable "service_account_email" {
  type = string
}

variable "keyring_vm_name" {
  type = string
}

variable "keyring_vm_location" {
  type = string
}

variable "crypto_key_vm_name" {
  type = string
}

variable "crypto_key_vm_rotation_period" {
  type = string
}

variable "crypto_key_vm_binding_role" {
  type = string
}

variable "crypto_key_vm_binding_member_1" {
  type = string
}

variable "keyring_cloud_sql_name" {
  type = string
}

variable "keyring_cloud_sql_location" {
  type = string
}

variable "crypto_key_cloud_sql_name" {
  type = string
}

variable "crypto_key_cloud_sql_purpose" {
  type = string
}

variable "gcp_sa_cloud_sql_service" {
  type = string
}

variable "iam_binding_crypto_key_cloud_sql_role" {
  type = string
}

variable "keyring_storage_buckets_name" {
  type = string
}

variable "keyring_storage_buckets_location" {
  type = string
}

variable "crypto_key_storage_buckets_name" {
  type = string
}

variable "crypto_key_storage_buckets_rotation_period" {
  type = string
}

variable "iam_binding_crypto_key_storage_buckets_role" {
  type = string
}

variable "iam_binding_crypto_key_storage_buckets_member_1" {
  type = string
}

variable "keyring_cloud_sql_project" {
  type = string
}

variable "gcp_sa_cloud_sql_project" {
  type = string
}