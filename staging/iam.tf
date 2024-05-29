resource "google_project_iam_member" "dataform_staging_roles" {
  for_each = toset([
    "roles/bigquery.dataEditor",
    "roles/bigquery.dataViewer",
    "roles/bigquery.user",
    "roles/bigquery.dataOwner",
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.dataform_staging.email}"

  depends_on = [
    google_service_account.dataform_staging
  ]
}

resource "google_service_account_iam_binding" "custom_service_account_token_creator" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.dataform_staging_service_account}@${var.project_id}.iam.gserviceaccount.com"

  role = "roles/iam.serviceAccountTokenCreator"

  members = [
    "serviceAccount:service-${var.project_number}@gcp-sa-dataform.iam.gserviceaccount.com"
  ]
  depends_on = [
    module.service-accounts
  ]
}

resource "google_secret_manager_secret_iam_binding" "github_secret_accessor" {
  secret_id = google_secret_manager_secret.dataform_github_token.secret_id

  role = "roles/secretmanager.secretAccessor"

  members = [
    "serviceAccount:service-${var.project_number}@gcp-sa-dataform.iam.gserviceaccount.com"
  ]

  depends_on = [
    google_secret_manager_secret.dataform_github_token,
    module.service-accounts,
  ]
}
