resource "google_project_iam_member" "dataform_prod_roles" {
  for_each = toset([
    "roles/bigquery.dataEditor",
    "roles/bigquery.dataViewer",
    "roles/bigquery.user",
    "roles/bigquery.dataOwner",
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.dataform_prod.email}"

  depends_on = [
    google_service_account.dataform_prod
  ]
}

resource "google_project_iam_member" "default_dataform_sa_prod_role" {
  project = var.project_id

  role   = "roles/iam.serviceAccountTokenCreator"
  member = "serviceAccount:service-${var.staging_project_number}@gcp-sa-dataform.iam.gserviceaccount.com"

  condition {
    title       = "RestrictToSpecificServiceAccount"
    description = "Applies this role only if the token is requested for the specific custom service account."
    expression  = "resource.name.startsWith('projects/${var.project_number}/serviceAccounts/${var.dataform_prod_service_account}@${var.project_id}.iam.gserviceaccount.com')"
  }

  depends_on = [
    google_service_account.dataform_prod
  ]
}