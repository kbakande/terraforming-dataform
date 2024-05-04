variable "project_id" {
  type        = string
  description = "Name of the GCP Project."
}

variable "region" {
  type        = string
  description = "The google cloud region to use"
  default     = "europe-west2"
}

variable "project_number" {
  type        = string
  description = "Number of the GCP Project."
}

variable "staging_project_number" {
  type        = string
  description = "Number of the staging GCP Project."
}

variable "location" {
  type        = string
  description = "The google cloud location in which to create resources"
  default     = "EU"
}

variable "dataform_prod_service_account" {
  type        = string
  description = "Email of the service account Dataform uses to execute queries in production"
}
