locals {
  services = toset([
    "compute.googleapis.com",
    "containerregistry.googleapis.com",
    "iam.googleapis.com",
    "run.googleapis.com",
    "sqladmin.googleapis.com"
  ])
}

resource "google_project_service" "project" {
  for_each                   = local.services
  project                    = var.PROJECT_ID
  service                    = each.value
  disable_dependent_services = true
}
