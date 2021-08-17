resource "google_compute_instance" "test-server" {
  name                      = "test-server"
  machine_type              = "f1-micro"
  allow_stopping_for_update = true
  zone                      = "asia-northeast1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.test-subnetwork1.name

    access_config {

    }
  }
}
