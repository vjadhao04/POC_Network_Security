resource "google_compute_network" "vpc_network1" {
  name                    = "vpc-net-1"
  auto_create_subnetworks ="false"
}

resource "google_compute_subnetwork" "vpc_subnet1" {
  name          = "vpc1-subnet-1"
  network       = "${google_compute_network.vpc_network1.self_link}"
  region = "us-central1"
  ip_cidr_range = "10.10.1.0/24"
  
  
 depends_on = [
    google_compute_network.vpc_network1
  ]
}
resource "google_compute_subnetwork" "vpc_subnet2" {
  name          = "vpc1-subnet-2"
  network       = "${google_compute_network.vpc_network1.self_link}"
  region = "us-west2"
  
  ip_cidr_range = "10.11.2.0/24"
  
  
 depends_on = [
    google_compute_network.vpc_network1
  ]
}



resource "google_compute_firewall" "vpc_network1_firewall" {
  name    = "vpc-network1-firewall"
  network =google_compute_network.vpc_network1.name
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


module "vm1_in_vpc1" {
  source              = "./instance"
  instance_name       = "vm1-in-vpc1-subnet1"
  instance_zone       = "us-central1-a"
  instance_network = "${google_compute_network.vpc_network1.self_link}"
  instance_subnetwork = "${google_compute_subnetwork.vpc_subnet1.self_link}"
  instance_tags = ["http-server","vm3"]
  #installing apache server
  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Hello World!</h1></body></html>' | sudo tee /var/www/html/index.html"

    #Apply the firewall rule to allow external IPs to access this instance
  #tags = ["http-server"]
  instance_email  = google_service_account.service_account.email
    instance_scopes = ["cloud-platform"]
}

module "vm2_in_vpc1" {
  source              = "./instance"
  instance_name       = "vm2-in-vpc1-subnet2"
  instance_zone       = "us-west2-a"
  instance_network = "${google_compute_network.vpc_network1.self_link}"
  instance_subnetwork = "${google_compute_subnetwork.vpc_subnet2.self_link}"
  instance_tags = ["http-server","vm3"]
  #installing apache server
  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Hello World!</h1></body></html>' | sudo tee /var/www/html/index.html"

    #Apply the firewall rule to allow external IPs to access this instance
  #tags = ["http-server"]
  instance_email  = google_service_account.service_account.email
    instance_scopes = ["cloud-platform"]
}
  



