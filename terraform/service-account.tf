resource "google_service_account" "cloud-run-sa" {
  account_id   = "cloud-run-sa"
  display_name = "Cloud Run Service Account"
}
resource "google_project_iam_member" "cloud-run-agent-iam" {
  role   = "roles/run.serviceAgent"
  member = "serviceAccount:${google_service_account.cloud-run-sa.email}"
}
resource "google_project_iam_member" "sql-for-cloud-run-iam" {
  role   = "roles/cloudsql.client"
  member = "serviceAccount:${google_service_account.cloud-run-sa.email}"
}
