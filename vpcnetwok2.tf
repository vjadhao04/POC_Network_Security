resource "google_compute_network" "vpc_network2" {
  name                    = "vpc-net-2"
  auto_create_subnetworks ="false"
}

resource "google_compute_subnetwork" "vpc2_subnet1" {
  name          = "vpc2-subnet-1"
  network       = google_compute_network.vpc_network2.name
  region = "us-central1"
  ip_cidr_range = "168.192.1.0/24"
  
  
 
}


resource "google_compute_firewall" "vpc_network2_firewall" {
  name    = "firewallvpc2"
  network =google_compute_network.vpc_network2.name
  priority = 1000
  source_ranges = ["0.0.0.0/0"] 
  allow {
    protocol = "tcp"
    ports    = ["22","80","1000-2000"]
  }
  allow{
      protocol="icmp"
  }
}

module "vm1_in_vpc2" {
  source              = "./instance"
  instance_name       = "vm1invpc2"
  instance_zone       = "us-central1-a"
  instance_network = "${google_compute_network.vpc_network2.self_link}"
  instance_subnetwork = "${google_compute_subnetwork.vpc2_subnet1.self_link}"
  instance_tags = ["http-server","vm3"]
  #installing apache server
  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Hello World!</h1></body></html>' | sudo tee /var/www/html/index.html"

    #Apply the firewall rule to allow external IPs to access this instance
  #tags = ["http-server"]
  instance_email  = google_service_account.service_account.email
    instance_scopes = ["cloud-platform"]
	
  
}
  



