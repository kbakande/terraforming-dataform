resource "google_secret_manager_secret" "dataform_github_token" {
  secret_id = var.dataform_github_token
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}