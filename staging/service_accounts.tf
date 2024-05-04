resource "google_service_account" "dataform_staging" {
  account_id   = var.dataform_staging_service_account
  display_name = "Dataform Service Account"
  project      = var.project_id
}
