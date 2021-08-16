resource "google_compute_instance" "test-server" {
  name         = "test"
  machine_type = "f1-micro"
  zone         = "asia-northeast1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2104"
    }
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {

    }
  }
}
