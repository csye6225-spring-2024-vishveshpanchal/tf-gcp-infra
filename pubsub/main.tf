resource "google_pubsub_topic" "verify_email" {
  name = "verify_email"

  # labels = {
  # foo = "bar"
  # }

  message_retention_duration = "604800s"
}

