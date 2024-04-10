resource "google_kms_key_ring" "keyring_vm" {
  name     = var.keyring_vm_name
  location = var.keyring_vm_location
}
# data "google_kms_key_ring" "keyring_vm" {
#   name     = "keyring-vm"
#   location = "us-east1"
# }

resource "google_kms_crypto_key" "key_vm" {
  name            = var.crypto_key_vm_name
  key_ring        = google_kms_key_ring.keyring_vm.id
  rotation_period = var.crypto_key_vm_rotation_period
  depends_on      = [google_kms_key_ring.keyring_vm]

  #   lifecycle {
  #     prevent_destroy = true
  #   }
}
# data "google_kms_crypto_key" "key_vm" {
#   name     = "crypto-key-vm"
#   key_ring = data.google_kms_key_ring.keyring_vm.id
# }

data "google_compute_default_service_account" "gcs_account" {
}

resource "google_kms_crypto_key_iam_binding" "key_vm_binding" {
  # crypto_key_id = data.google_kms_crypto_key.key_vm.id
  crypto_key_id = google_kms_crypto_key.key_vm.id
  depends_on    = [google_kms_crypto_key.key_vm]
  #   depends_on    = [google_kms_crypto_key.key_storage_buckets]
  role = var.crypto_key_vm_binding_role

  # members = ["serviceAccount:${data.google_compute_default_service_account.gcs_account.email}"]
  members = [var.crypto_key_vm_binding_member_1]

}




resource "google_kms_key_ring" "keyring_cloud_sql" {
  provider = google-beta
  name     = var.keyring_cloud_sql_name
  location = var.keyring_cloud_sql_location
  project  = var.keyring_cloud_sql_project
}
# data "google_kms_key_ring" "keyring_cloud_sql" {
#   name     = "keyring-cloud-sql"
#   location = "us-east1"
# }

resource "google_kms_crypto_key" "key_cloud_sql" {
  provider   = google-beta
  name       = var.crypto_key_cloud_sql_name
  key_ring   = google_kms_key_ring.keyring_cloud_sql.id
  depends_on = [google_kms_key_ring.keyring_cloud_sql]
  purpose    = var.crypto_key_cloud_sql_purpose
  #   lifecycle {
  #     prevent_destroy = true
  #   }
}
# data "google_kms_crypto_key" "key_cloud_sql" {
#   name     = "crypto-key-cloud-sql"
#   key_ring = data.google_kms_key_ring.keyring_cloud_sql.id
# }

resource "google_project_service_identity" "gcp_sa_cloud_sql" {
  provider = google-beta
  service  = var.gcp_sa_cloud_sql_service
  project  = var.gcp_sa_cloud_sql_project
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  provider = google-beta
  # crypto_key_id = data.google_kms_crypto_key.key_cloud_sql.id
  crypto_key_id = google_kms_crypto_key.key_cloud_sql.id
  role          = var.iam_binding_crypto_key_cloud_sql_role
  depends_on    = [google_kms_crypto_key.key_cloud_sql]
  members = [
    "serviceAccount:${google_project_service_identity.gcp_sa_cloud_sql.email}",
  ]
}






resource "google_kms_key_ring" "keyring_storage_buckets" {
  name     = var.keyring_storage_buckets_name
  location = var.keyring_storage_buckets_location
}
# data "google_kms_key_ring" "keyring_storage_buckets" {
#   name     = "keyring-storage-bucket"
#   location = "us-east1"
# }

resource "google_kms_crypto_key" "key_storage_buckets" {
  name            = var.crypto_key_storage_buckets_name
  key_ring        = google_kms_key_ring.keyring_storage_buckets.id
  depends_on      = [google_kms_key_ring.keyring_storage_buckets]
  rotation_period = var.crypto_key_storage_buckets_rotation_period

  #   lifecycle {
  #     prevent_destroy = true
  #   }
}
# data "google_kms_crypto_key" "key_storage_buckets" {
#   name     = "crypto-key-storage-buckets"
#   key_ring = data.google_kms_key_ring.keyring_storage_buckets.id
# }

data "google_storage_project_service_account" "gcs_account" {
}

resource "google_kms_crypto_key_iam_binding" "binding" {
  # crypto_key_id = data.google_kms_crypto_key.key_storage_buckets.id
  crypto_key_id = google_kms_crypto_key.key_storage_buckets.id
  depends_on    = [google_kms_crypto_key.key_storage_buckets]
  role          = var.iam_binding_crypto_key_storage_buckets_role

  # members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
  members = [var.iam_binding_crypto_key_storage_buckets_member_1]

}