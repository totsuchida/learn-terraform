resource "google_cloud_run_service" "cloud-run-test" {
  name     = "cloud-run-test"
  location = var.DEFAULT_REGION

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
        resources {
          limits = { "cpu" : "1000m", "memory" : "128Mi" }
        }
      }
      service_account_name = google_service_account.cloud-run-sa.email
    }
    metadata {
      annotations = {
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.sql-test-instance.connection_name
        "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.test-network-connector.name
      }
    }
  }

}