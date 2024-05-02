variable "project_id" {
  type        = string
  description = "Name of the GCP Project."
}

variable "env" {
  type        = string
  description = "Environment Tag (nonprod/prod)."
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

variable "location" {
  type        = string
  description = "The google cloud location in which to create resources"
  default     = "EU"
}

variable "dataform_staging_service_account" {
  type        = string
  description = "Email of the service account Dataform uses to execute queries in staging env"
}

variable "dataform_prod_service_account" {
  type        = string
  description = "Email of the service account Dataform uses to execute queries in production"
}

variable "dataform_github_token" {
  description = "Dataform GitHub Token"
  type        = string
  sensitive   = true
}