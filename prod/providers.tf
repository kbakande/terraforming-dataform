terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=5.14.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">=5.14.0"
    }
  }

  required_version = ">= 1.7.3"
}

provider "google" {
  project = var.project_id
}
