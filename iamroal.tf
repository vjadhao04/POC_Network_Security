resource "google_project_iam_member" "iamrole" {
  project = "gcp-poc-project-346311"
  role    = "roles/editor"
  member  = "user:purvachandge7@gmail.com"
}

resource "google_service_account" "service_account" {
  account_id = "serviceaccount"
  display_name = "Service_account"
}

resource "google_project_iam_member" "firestore_owner_binding" {
  project = "gcp-poc-project-346311"
  role    = "roles/viewer"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}