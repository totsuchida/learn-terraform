resource "google_sql_database" "cloud-sql-test-db" {
  name     = "cloud-sql-test-db"
  instance = google_sql_database_instance.cloud-sql-test-instance.name
}

resource "google_sql_database_instance" "cloud-sql-test-instance" {
  name             = "cloud-sql-test-instance"
  database_version = "MYSQL_8_0"
  region           = var.DEFAULT_REGION

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_size         = 10
  }
}