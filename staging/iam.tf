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

resource "google_project_iam_member" "default_dataform_sa_staging_role" {
  project = var.project_id

  role   = "roles/iam.serviceAccountTokenCreator"
  member = "serviceAccount:service-${var.project_number}@gcp-sa-dataform.iam.gserviceaccount.com"

  condition {
    title       = "RestrictToSpecificServiceAccount"
    description = "Applies this role only if the token is requested for the specific custom service account."
    expression  = "resource.name.startsWith('projects/${var.project_number}/serviceAccounts/${var.dataform_staging_service_account}@${var.project_id}.iam.gserviceaccount.com')"
  }

  depends_on = [
    google_service_account.dataform_staging
  ]
}

resource "google_project_iam_member" "default_dataform_sa_secret_assess" {
  project = var.project_id

  role   = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:service-${var.project_number}@gcp-sa-dataform.iam.gserviceaccount.com"

  condition {
    title       = "RestrictToSpecificSecret"
    description = "Applies this role only if accessing staging dataform github token."
    expression  = "resource.name.startsWith('projects/${var.project_number}/secrets/${google_secret_manager_secret.dataform_github_token.secret_id}')"
  }

  depends_on = [
    google_secret_manager_secret.dataform_github_token,
    google_service_account.dataform_staging
  ]
}