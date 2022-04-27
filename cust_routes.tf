
resource "google_compute_route" "route1" {
  name       = "route1"
  network    = google_compute_network.vpc_network1.name
  dest_range = "111.14.2.0/24"
  priority   = 1000
  

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1.id
}

resource "google_compute_route" "route2" {
  name       = "route2"
  network    = google_compute_network.vpc_network2.name
  dest_range = "115.0.0.0/24"
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel2.id
}