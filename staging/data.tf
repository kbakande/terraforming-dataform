data "google_secret_manager_secret_version" "dataform_github_token" {
  project = var.project_id
  secret  = var.dataform_github_token

  depends_on = [
    google_secret_manager_secret.dataform_github_token
  ]
}