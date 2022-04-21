provider "google" {
    credentials="${file("${var.path}/gcp-poc-project.json")}"
    project = "${var.project}"
}