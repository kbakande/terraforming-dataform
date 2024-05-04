resource "google_secret_manager_secret" "dataform_github_token" {
  project   = var.project_id
  secret_id = var.dataform_github_token
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}