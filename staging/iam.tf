resource "google_project_iam_member" "dataform_nonprod_roles" {
  for_each = toset([
    "roles/bigquery.dataEditor",
    "roles/bigquery.dataViewer",
    "roles/bigquery.user",
    "roles/bigquery.dataOwner",
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.dataform_nonprod.email}"

  depends_on = [ 
    google_service_account.dataform_nonprod
   ]
}

