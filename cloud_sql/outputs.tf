output "webapp_env_DB_USERNAME_PROD" {
  value = google_sql_user.sql_users.name
}

output "webapp_env_DB_PASSWORD_PROD" {
  value = google_sql_user.sql_users.password
}

output "webapp_env_DB_NAME_PROD" {
  value = google_sql_database.sql_database.name
}

output "webapp_env_DB_HOST_PROD" {
  value = google_compute_address.default.address
}