resource "google_sql_database" "sql-test-db" {
  name     = "sql-test-db"
  instance = google_sql_database_instance.sql-test-instance.name
}

resource "google_sql_database_instance" "sql-test-instance" {
  name             = "sql-test-instance"
  database_version = "MYSQL_8_0"
  region           = var.DEFAULT_REGION

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_size         = 10
  }
}