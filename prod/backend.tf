terraform {
  backend "gcs" {
    bucket = "dataform-prod-terraform-state"
    prefix = "terraform/state"
  }
}
