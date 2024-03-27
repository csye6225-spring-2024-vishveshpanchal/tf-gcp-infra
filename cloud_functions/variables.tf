variable "storage_bucket_function_name" {
  type = string
}

variable "storage_bucket_function_location" {
  type = string
}

variable "storage_bucket_function_force_destroy" {
  type = string
}

variable "storage_bucket_function_storage_class" {
  type = string
}

variable "storage_bucket_function_public_access_prevention" {
  type = string
}

variable "storage_bucket_function_uniform_bucket_level_access" {
  type = string
}

variable "storage_bucket_object_function_name" {
  type = string
}

variable "storage_bucket_object_function_source" {
  type = string
}

variable "send_verification_email_cloud_function_name" {
  type = string
}

variable "pubsub_topic_verify_email" {
  type = string
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

variable "webapp_env_DB_PORT_PROD" {
  type = string
}

variable "cloud_function_MAIL_DOMAIN_NAME" {
  type = string
}

variable "cloud_function_MAILGUN_API_KEY" {
  type = string
}

variable "cloud_function_WEBAPP_DOMAIN_NAME" {
  type = string
}

variable "cloud_function_TOKEN_EXPIRY_TIME_MIN" {
  type = string
}

variable "webapp_env_PORT" {
  type = string
}

variable "connector_function_cloudsql_name" {
  type = string
}

variable "send_verification_email_cloud_function_google_service_account_account_id" {
  type = string
}

variable "send_verification_email_cloud_function_google_service_account_display_name" {
  type = string
}

variable "gcp_project" {
  type = string
}

variable "google_project_iam_binding_send_verification_email_cloud_function_run_invoker" {
  type = string
}

variable "google_project_iam_binding_send_verification_email_cloud_function_pubsub_subscriber" {
  type = string
}

variable "send_verification_email_cloud_function_ingress_settings" {
  type = string
}

variable "send_verification_email_cloud_function_event_trigger_event_type" {
  type = string
}

variable "send_verification_email_cloud_function_vpc_connector_egress_settings" {
  type = string
}

variable "send_verification_email_cloud_function_runtime" {
  type = string
}

variable "send_verification_email_cloud_function_available_memory_mb" {
  type = string
}

variable "send_verification_email_cloud_function_location" {
  type = string
}

variable "send_verification_email_cloud_function_entry_point" {
  type = string
}

variable "send_verification_email_cloud_function_max_instance_count" {
  type = number
}

variable "send_verification_email_cloud_function_min_instance_count" {
  type = number
}

variable "send_verification_email_cloud_function_available_memory" {
  type = string
}

variable "send_verification_email_cloud_function_timeout_seconds" {
  type = string
}

variable "send_verification_email_cloud_function_max_instance_request_concurrency" {
  type = string
}

variable "send_verification_email_cloud_function_available_cpu" {
  type = string
}

variable "send_verification_email_cloud_function_trigger_region" {
  type = string
}

variable "send_verification_email_cloud_function_retry_policy" {
  type = string
}