output "key_vm_self_link" {
  value = google_kms_crypto_key.key_vm.id
  # value = data.google_kms_crypto_key.key_vm.id # https://github.com/hashicorp/terraform-provider-google/issues/11272
}

output "key_cloud_sql_id" {
  value = google_kms_crypto_key.key_cloud_sql.id
  # value = data.google_kms_crypto_key.key_cloud_sql.id
}

output "key_storage_buckets_id" {
  value = google_kms_crypto_key.key_storage_buckets.id
  # value = data.google_kms_crypto_key.key_storage_buckets.id
}

output "storage_buckets_iam" {
  value = google_kms_crypto_key_iam_binding.binding
}

output "gcp_sa_iam_compute" {
  value = google_kms_crypto_key_iam_binding.key_vm_binding
}