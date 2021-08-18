resource "google_sql_database_instance" "cloud-sql-test" {
  name             = "cloud-sql-test"
  database_version = "MYSQL_8_0"
  region           = var.DEFAULT_REGION

  settings {
    tier = "db-f1-micro"
  }
}