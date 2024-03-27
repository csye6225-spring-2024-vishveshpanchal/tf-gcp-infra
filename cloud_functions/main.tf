# resource "google_storage_bucket" "storage_bucket_function" {
#   name                        = var.storage_bucket_function_name
#   location                    = var.storage_bucket_function_location
#   force_destroy               = var.storage_bucket_function_force_destroy
#   storage_class               = var.storage_bucket_function_storage_class
#   public_access_prevention    = var.storage_bucket_function_public_access_prevention    # "inherited" or "enforced" (Defaults to "inherited")
#   uniform_bucket_level_access = var.storage_bucket_function_uniform_bucket_level_access # Default: false
# }

# resource "google_storage_bucket_object" "storage_bucket_object_function" {
#   name   = var.storage_bucket_object_function_name
#   source = var.storage_bucket_object_function_source
#   bucket = google_storage_bucket.storage_bucket_function.name

#   depends_on = [google_storage_bucket.storage_bucket_function]
# }

data "google_storage_bucket" "my-bucket" {
  name = var.storage_bucket_function_name
}

resource "google_service_account" "send_verification_email_cloud_function_google_service_account_account" {
  account_id   = var.send_verification_email_cloud_function_google_service_account_account_id
  display_name = var.send_verification_email_cloud_function_google_service_account_display_name
}

resource "google_project_iam_binding" "send_verification_email_cloud_function_run_invoker" {
  project = var.gcp_project
  role    = var.google_project_iam_binding_send_verification_email_cloud_function_run_invoker

  members = [
    "serviceAccount:${google_service_account.send_verification_email_cloud_function_google_service_account_account.email}",
  ]

  depends_on = [google_service_account.send_verification_email_cloud_function_google_service_account_account]
}

resource "google_project_iam_binding" "send_verification_email_cloud_function_pubsub_subscriber" {
  project = var.gcp_project
  role    = var.google_project_iam_binding_send_verification_email_cloud_function_pubsub_subscriber

  members = [
    "serviceAccount:${google_service_account.send_verification_email_cloud_function_google_service_account_account.email}",
  ]
  depends_on = [google_service_account.send_verification_email_cloud_function_google_service_account_account]
}

# OLD - Cloud Functions gen2
resource "google_cloudfunctions2_function" "send_verification_email_cloud_function" {
  name     = var.send_verification_email_cloud_function_name
  location = var.send_verification_email_cloud_function_location

  build_config {
    runtime     = var.send_verification_email_cloud_function_runtime
    entry_point = var.send_verification_email_cloud_function_entry_point

    source {
      storage_source {
        bucket = data.google_storage_bucket.my-bucket.name
        object = var.storage_bucket_object_function_name
        # bucket = google_storage_bucket.storage_bucket_function.name
        # object = google_storage_bucket_object.storage_bucket_object_function.name
      }
    }
  }

  service_config {
    max_instance_count               = var.send_verification_email_cloud_function_max_instance_count
    min_instance_count               = var.send_verification_email_cloud_function_min_instance_count
    available_memory                 = var.send_verification_email_cloud_function_available_memory
    timeout_seconds                  = var.send_verification_email_cloud_function_timeout_seconds
    max_instance_request_concurrency = var.send_verification_email_cloud_function_max_instance_request_concurrency
    available_cpu                    = var.send_verification_email_cloud_function_available_cpu
    environment_variables = {
      DB_USERNAME           = var.webapp_env_DB_USERNAME_PROD
      DB_PASSWORD           = var.webapp_env_DB_PASSWORD_PROD
      DB_NAME               = var.webapp_env_DB_NAME_PROD
      DB_HOST               = var.webapp_env_DB_HOST_PROD
      DB_PORT               = var.webapp_env_DB_PORT_PROD
      MAIL_DOMAIN_NAME      = var.cloud_function_MAIL_DOMAIN_NAME
      MAILGUN_API_KEY       = var.cloud_function_MAILGUN_API_KEY
      WEBAPP_DOMAIN_NAME    = var.cloud_function_WEBAPP_DOMAIN_NAME
      WEBAPP_PORT           = var.webapp_env_PORT
      TOKEN_EXPIRY_TIME_MIN = var.cloud_function_TOKEN_EXPIRY_TIME_MIN
    }
    ingress_settings              = var.send_verification_email_cloud_function_ingress_settings
    vpc_connector                 = var.connector_function_cloudsql_name
    vpc_connector_egress_settings = var.send_verification_email_cloud_function_vpc_connector_egress_settings

    service_account_email = google_service_account.send_verification_email_cloud_function_google_service_account_account.email
  }

  event_trigger {
    trigger_region        = var.send_verification_email_cloud_function_trigger_region
    event_type            = var.send_verification_email_cloud_function_event_trigger_event_type
    pubsub_topic          = var.pubsub_topic_verify_email
    retry_policy          = var.send_verification_email_cloud_function_retry_policy
    service_account_email = google_service_account.send_verification_email_cloud_function_google_service_account_account.email
  }
}

// OLD - Cloud Functions gen1
# resource "google_cloudfunctions_function" "send_verification_email_cloud_function" {
#   name        = var.send_verification_email_cloud_function_name
#   runtime = var.send_verification_email_cloud_function_runtime
#   available_memory_mb = var.send_verification_email_cloud_function_available_memory_mb
#   region = var.send_verification_email_cloud_function_region

#   event_trigger{
#     event_type = var.send_verification_email_cloud_function_event_trigger_event_type
#     resource = var.pubsub_topic_verify_email # SURE???
#   }

#   ingress_settings = var.send_verification_email_cloud_function_ingress_settings
#   service_account_email = google_service_account.send_verification_email_cloud_function_google_service_account_account.email
#   environment_variables = {
#     DB_USERNAME = var.webapp_env_DB_USERNAME_PROD
#     DB_PASSWORD = var.webapp_env_DB_PASSWORD_PROD
#     DB_NAME = var.webapp_env_DB_NAME_PROD
#     DB_HOST = var.webapp_env_DB_HOST_PROD
#     DB_PORT = var.webapp_env_DB_PORT_PROD
#     MAIL_DOMAIN_NAME = var.cloud_function_MAIL_DOMAIN_NAME
#     MAILGUN_API_KEY = var.cloud_function_MAILGUN_API_KEY
#     WEBAPP_DOMAIN_NAME = var.cloud_function_WEBAPP_DOMAIN_NAME
#     WEBAPP_PORT = var.webapp_env_PORT
#     TOKEN_EXPIRY_TIME_MIN = var.cloud_function_TOKEN_EXPIRY_TIME_MIN
#   }

#   vpc_connector = var.connector_function_cloudsql_selflink
#   vpc_connector_egress_settings = var.send_verification_email_cloud_function_vpc_connector_egress_settings

#   source_archive_bucket = google_storage_bucket.storage_bucket_function.name
#   source_archive_object = google_storage_bucket_object.storage_bucket_object_function.name

#   min_instances = "0"
#   max_instances = "1"

#   depends_on = [ google_storage_bucket_object.storage_bucket_object_function ]
# }