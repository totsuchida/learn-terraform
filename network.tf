resource "google_compute_network" "test-network" {
  name                    = "test-network"
  auto_create_subnetworks = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_subnetwork" "test-subnetwork1" {
  name          = "test-subnetwork1"
  ip_cidr_range = "10.1.0.0/16"
  region        = "asia-northeast1"
  network       = google_compute_network.test-network.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.test-network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
