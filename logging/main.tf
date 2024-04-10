resource "google_service_account" "default" {
  account_id   = var.google_service_account_account_id
  display_name = var.google_service_account_display_name
}

resource "google_project_iam_binding" "logging_admin" {
  project = var.gcp_project
  role    = var.google_project_iam_binding_logging_admin_role

  members = [
    "serviceAccount:${google_service_account.default.email}",
  ]

  depends_on = [google_service_account.default]
}

resource "google_project_iam_binding" "monitoring_metric_writer" {
  project = var.gcp_project
  role    = var.google_project_iam_binding_monitoring_metric_writer_role

  members = [
    "serviceAccount:${google_service_account.default.email}",
  ]
  depends_on = [google_service_account.default]
}

resource "google_project_iam_binding" "pubsub_publisher" {
  project = var.gcp_project
  role    = var.google_project_iam_binding_pubsub_publisher

  members = [
    "serviceAccount:${google_service_account.default.email}",
  ]
  depends_on = [google_service_account.default]
}

resource "google_project_iam_binding" "keyRings_create" {
  project = var.gcp_project
  role    = var.google_project_iam_binding_keyRings_create_role
  # role = "roles/cloudkms.keyRings.create"
  members = [
    "serviceAccount:${google_service_account.default.email}",
  ]

  depends_on = [google_service_account.default]
}
# resource "google_project_iam_binding" "keyRings_create" {
#   project = "dev-csye-6225-webapp-1"
#   #   role    = "roles/cloudkms.admin"
#   role = "roles/cloudkms.keyRings.create"
#   members = [
#     "serviceAccount:${google_service_account.default.email}",
#   ]

#   depends_on = [google_service_account.default]
# }

# resource "google_project_iam_binding" "keyRings_get" {
#   project = "dev-csye-6225-webapp-1"
#   role    = "roles/cloudkms.keyRings.get"
#   members = [
#     "serviceAccount:${google_service_account.default.email}",
#   ]

#   depends_on = [google_service_account.default]
# }

# resource "google_project_iam_binding" "keyRings_list" {
#   project = "dev-csye-6225-webapp-1"
#   role    = "roles/cloudkms.keyRings.list"
#   members = [
#     "serviceAccount:${google_service_account.default.email}",
#   ]

#   depends_on = [google_service_account.default]
# }

# resource "google_project_iam_binding" "locations_get" {
#   project = "dev-csye-6225-webapp-1"
#   role    = "roles/cloudkms.locations.get"
#   members = [
#     "serviceAccount:${google_service_account.default.email}",
#   ]

#   depends_on = [google_service_account.default]
# }

# resource "google_project_iam_binding" "locations_list" {
#   project = "dev-csye-6225-webapp-1"
#   role    = "roles/cloudkms.locations.list"
#   members = [
#     "serviceAccount:${google_service_account.default.email}",
#   ]

#   depends_on = [google_service_account.default]
# }

# resource "google_project_iam_binding" "resourcemanager_projects_get" {
#   project = "dev-csye-6225-webapp-1"
#   role    = "roles/cloudkms.resourcemanager.projects.get"
#   members = [
#     "serviceAccount:${google_service_account.default.email}",
#   ]

#   depends_on = [google_service_account.default]
# }

# resource "google_project_iam_member" "hc_sa_bq_jobuser" {
#   project = data.google_project.project.project_id
#   role    = "roles/bigquery.jobUser"
#   member  = "serviceAccount:${google_project_service_identity.hc_sa.email}"
# }