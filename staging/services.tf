
# Enable Secret Manager API
resource "google_project_service" "secret_manager" {
  project = var.project_id
  service = "secretmanager.googleapis.com"
}