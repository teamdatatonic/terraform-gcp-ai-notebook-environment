resource "google_kms_key_ring" "notebook_keyring" {
  name = "${var.project_id}-ainb-keyring"

  project  = var.project_id
  location = var.region
}

resource "google_kms_crypto_key" "instance_key" {
  for_each = var.notebook_environment_config.instance_config

  name     = "${each.key}-nb-instance-key"
  key_ring = google_kms_key_ring.notebook_keyring.id

  rotation_period = lookup(each.value, "kms_rotation_period", "100000s")

}
