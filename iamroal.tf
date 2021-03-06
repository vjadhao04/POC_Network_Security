resource "google_project_iam_member" "iamrole" {
    project = "${var.project}"
    role    = "roles/editor"
    member  = "user:purvachandge7@gmail.com"
}

resource "google_service_account" "service_account" {
    account_id   = "serviceaccount"
    display_name = "Service_account"
}

resource "google_project_iam_member" "viewer_binding" {
    project   = "${var.project}"
    role      = "roles/viewer"
    member    = "serviceAccount:${google_service_account.service_account.email}"
}