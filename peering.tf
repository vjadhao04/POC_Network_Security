resource "google_compute_network_peering" "primary_network" {
  name         = "peering1"
  network      = google_compute_network.vpc_network1.self_link
  peer_network =  google_compute_network.vpc_network2.self_link

  import_custom_routes = true
  export_custom_routes = true
}

resource "google_compute_network_peering" "peered_network" {
  name         = "peering2"
  network      = google_compute_network.vpc_network2.self_link
  peer_network =  google_compute_network.vpc_network1.self_link

  import_custom_routes = true
  export_custom_routes = true
}
  # Note: have to create the peering sequentially as there is a race condition
  

# resource "google_compute_network_peering_routes_config" "primary_network" {
#   project = var.project
#   network = google_compute_network.vpc_network1.name
#   peering = google_compute_network_peering.primary_network.name

#   import_custom_routes = true
#   export_custom_routes = true
# }

# resource "google_compute_network_peering_routes_config" "peered_network" {
#   project = var.project
#   network = google_compute_network.vpc_network2.name
#   peering = google_compute_network_peering.peered_network.name

#   import_custom_routes = true
#   export_custom_routes = true

#   # Note: have to create the peering sequentially as there is a race condition
#   depends_on = [google_compute_network_peering_routes_config.primary_network]
# }
