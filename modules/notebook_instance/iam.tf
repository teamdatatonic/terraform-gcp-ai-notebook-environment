resource "google_service_account" "notebook_service_account" {
  for_each = var.notebook_environment_config.instance_config

  project      = var.project_id
  account_id   = "${each.key}-nb-sa"
  display_name = "Service Account"
}

resource "google_notebooks_instance_iam_member" "nb_instance_access" {
  # Access to the specific instance
  for_each = var.notebook_environment_config.instance_config

  instance_name = google_notebooks_instance.nb_instance[each.key].name
  project       = var.project_id
  location      = var.notebook_environment_config.location

  member = "serviceAccount:${google_service_account.notebook_service_account[each.key].email}"
  role   = "roles/notebooks.admin"
}

resource "google_kms_crypto_key_iam_member" "notebook_sa_crypto_iam" {
  for_each = var.notebook_environment_config.instance_config

  crypto_key_id = google_kms_crypto_key.instance_key[each.key].id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${google_service_account.notebook_service_account[each.key].email}"
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  for_each      = var.notebook_environment_config.instance_config
  crypto_key_id = google_kms_crypto_key.instance_key[each.key].id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:service-${var.project_number}@compute-system.iam.gserviceaccount.com",
  ]
}
