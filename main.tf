provider "google" {
    credentials="${file("${var.path}/gcp-poc-project.json")}"
    project = "gcp-poc-project-346311"
    region  = "us-central1"
    zone    = "us-central1-c"
}