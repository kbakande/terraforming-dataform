terraform {
  backend "gcs" {
    bucket = "dataform-staging-terraform-state"
    prefix = "terraform/state"
  }
}
