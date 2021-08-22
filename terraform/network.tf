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
  region        = var.DEFAULT_REGION
  network       = google_compute_network.test-network.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_subnetwork" "test-connector-subnet" {
  name = "test-connector-subnet"
  ip_cidr_range = "10.11.0.0/28"
  region = var.DEFAULT_REGION
  network = google_compute_network.test-network.id
}

resource "google_vpc_access_connector" "test-network-connector" {
  provider = google-beta
  name = "test-network-connector"
  subnet {
    name = google_compute_subnetwork.test-connector-subnet.name
  }
  machine_type = "f1-micro"
}


resource "google_compute_firewall" "test-firewall" {
  name    = "test-firewall"
  network = google_compute_network.test-network.name

  priority = 1000

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["test-server"]

  allow {
    protocol = "icmp"
  }

  lifecycle {
    create_before_destroy = true
  }
}
