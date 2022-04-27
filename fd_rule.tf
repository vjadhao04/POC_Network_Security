
resource "google_compute_forwarding_rule" "fr_esp" {
  name        = "fr-esp"
  region      = "us-central1"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip1.address
  target      = google_compute_vpn_gateway.gt1.id
}

resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "fr-udp500"
  region      = "us-central1"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip1.address
  target      = google_compute_vpn_gateway.gt1.id
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "fr-udp4500"
  region      = "us-central1"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip1.address
  target      = google_compute_vpn_gateway.gt1.id
}

resource "google_compute_forwarding_rule" "fr_esp-2" {
  name        = "fr-esp-2"
  region      = "europe-west1"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip2.address
  target      = google_compute_vpn_gateway.gt2.id
}

resource "google_compute_forwarding_rule" "fr_udp500-2" {
  name        = "fr-udp500-2"
  region      = "europe-west1"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip2.address
  target      = google_compute_vpn_gateway.gt2.id
}

resource "google_compute_forwarding_rule" "fr_udp4500-2" {
  name        = "fr-udp4500-2"
  region      = "europe-west1"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip2.address
  target      = google_compute_vpn_gateway.gt2.id
}

