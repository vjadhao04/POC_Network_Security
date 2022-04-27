
resource "google_compute_address" "vpn_static_ip1" {
  name = "vpn-static-ip1"
  region="us-central1"
}

resource "google_compute_address" "vpn_static_ip2" {
  name = "vpn-static-ip2"
  region="europe-west1"
}

 
resource "google_compute_vpn_gateway" "gt1" {
  name    = "vpn1"
  network = google_compute_network.vpc_network1.id
  region="us-central1"
}
resource "google_compute_vpn_gateway" "gt2" {
  name    = "vpn2"
  network = google_compute_network.vpc_network2.id
  region="europe-west1"
}





resource "google_compute_vpn_tunnel" "tunnel1" {
  name          = "tunnel1"
  peer_ip       = google_compute_address.vpn_static_ip2.address
  shared_secret = "a secret message"
  local_traffic_selector=["0.0.0.0/0"]

  target_vpn_gateway = google_compute_vpn_gateway.gt1.id

  depends_on = [
    google_compute_forwarding_rule.fr_esp,
    google_compute_forwarding_rule.fr_udp500,
    google_compute_forwarding_rule.fr_udp4500,
  ]
}

resource "google_compute_vpn_tunnel" "tunnel2" {
  name          = "tunnel2"
  peer_ip       = google_compute_address.vpn_static_ip1.address
  shared_secret = "a secret message"
  local_traffic_selector=["0.0.0.0/0"]

  target_vpn_gateway = google_compute_vpn_gateway.gt2.id

  depends_on = [
    google_compute_forwarding_rule.fr_esp-2,
    google_compute_forwarding_rule.fr_udp500-2,
    google_compute_forwarding_rule.fr_udp4500-2,
  ]
}




