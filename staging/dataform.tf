resource "google_dataform_repository" "dataform_demo" {
  provider        = google-beta
  name            = "dataform_demo"
  project         = var.project_id
  region          = var.region
  service_account = var.dataform_staging_service_account

  git_remote_settings {
    url                                 = "https://github.com/kbakande/dataform-001"
    default_branch                      = "main"
    authentication_token_secret_version = data.google_secret_manager_secret_version.dataform_github_token.id
  }

  workspace_compilation_overrides {
    default_database = var.project_id
  }

}

resource "google_dataform_repository_release_config" "prod_release" {
  provider   = google-beta
  project    = var.project_id
  region     = var.region
  repository = google_dataform_repository.dataform_demo.name

  name          = "prod"
  git_commitish = "main"
  cron_schedule = "30 6 * * *"

  code_compilation_config {
    default_database = var.project_id
    default_location = var.location
    default_schema   = "dataform"
    assertion_schema = "dataform_assertions"
  }

  depends_on = [
    google_dataform_repository.dataform_demo
  ]
}

resource "google_dataform_repository_workflow_config" "prod_schedule" {
  provider = google-beta
  project  = var.project_id
  region   = var.region

  name           = "prod_daily_schedule"
  repository     = google_dataform_repository.dataform_demo.name
  release_config = google_dataform_repository_release_config.prod_release.id
  cron_schedule  = "45 6 * * *"

  invocation_config {
    included_tags                            = []
    transitive_dependencies_included         = false
    transitive_dependents_included           = false
    fully_refresh_incremental_tables_enabled = false

    service_account = var.dataform_prod_service_account
  }

  depends_on = [
    google_dataform_repository.dataform_demo
  ]
}
