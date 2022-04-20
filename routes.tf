resource "google_compute_route" "routes1" {
  name        = "router1"
  dest_range  = "168.130.0.0/20"
  network     = "vpc-net-1"
  tags = ["vm1"]
  next_hop_instance="vm1invpc2"
  next_hop_instance_zone="us-central1-a"
  priority    = 0
  depends_on = [module.vm1_in_vpc2]
 

}


resource "google_compute_route" "r2" {
  name        = "route2"
  dest_range  = "168.192.1.0/24"
  network     = "vpc-net-2"
  
  next_hop_instance="vm1invpc1"
  next_hop_instance_zone="us-central1-a"
  priority    = 0
 depends_on = [
   module.vm1_in_vpc1
 ]
}