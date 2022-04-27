variable "instance_name" {}
variable "instance_zone" {}


variable "instance_type" {
  default = "e2-micro"
}
variable "instance_network" {
  
}
variable "instance_subnetwork" {}
variable "instance_email" {}
variable "instance_scopes" {}
variable "instance_tags" {}
variable "metadata_startup_script" {}
#creating instance


resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  zone         = var.instance_zone
  machine_type = var.instance_type
 

  tags=var.instance_tags
  metadata_startup_script=var.metadata_startup_script
  boot_disk {
    initialize_params {
     image = "debian-cloud/debian-9"
    }
  }
  can_ip_forward ="true"
  network_interface {
    #network = 
    subnetwork ="${var.instance_subnetwork}"
    access_config {
       
    }
  }

    service_account {
    email  = "${var.instance_email}"
    scopes = "${var.instance_scopes}"
  }
}