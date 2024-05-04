resource "google_service_account" "dataform_prod" {
  account_id   = var.dataform_prod_service_account
  display_name = "Dataform Service Account"
  project      = var.project_id
}
