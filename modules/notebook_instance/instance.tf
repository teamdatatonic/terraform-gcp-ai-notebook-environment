resource "google_project_service" "notebook_services" {
  for_each = toset(var.service_list)

  project = var.project_id
  service = "${each.value}.googleapis.com"
}


resource "google_notebooks_instance" "nb_instance" {
  for_each = var.notebook_environment_config.instance_config

  name     = "${var.project_id}-${each.key}-ainb"
  project  = var.project_id
  location = var.notebook_environment_config.location

  labels   = lookup(each.value, "labels", {})
  metadata = lookup(each.value, "metadata", {})
  tags     = lookup(each.value, "tags", [])

  # Container

  machine_type = each.value.machine_type
  container_image {
    repository = each.value.container_config.repository
    tag        = each.value.container_config.tag
  }

  # Encryption & Security
  disk_encryption = "CMEK"
  kms_key         = google_kms_crypto_key.instance_key[each.key].self_link

  shielded_instance_config {
    enable_integrity_monitoring = each.value.shielded
    enable_secure_boot          = each.value.shielded
    enable_vtpm                 = each.value.shielded
  }

  service_account = google_service_account.notebook_service_account[each.key].email

  # Data & Storage
  boot_disk_type      = lookup(each.value, "boot_disk", "PD_SSD")
  boot_disk_size_gb   = lookup(each.value, "boot_disk_size_gb", 100)
  data_disk_type      = lookup(each.value, "data_disk", "PD_SSD")
  data_disk_size_gb   = lookup(each.value, "data_disk_size_gb", 100)
  no_remove_data_disk = lookup(each.value, "persistence_disk", false)

  # Network
  network = var.network_name
  subnet  = var.subnet_name

  # GPUs
  install_gpu_driver = lookup(each.value, "gpu_config", {}) == {} ? false : true

  dynamic "accelerator_config" {
    for_each = lookup(each.value, "gpu_config", {})

    content {
      type       = lookup(accelerator_config, "type", var.default_gpu_instance)
      core_count = lookup(accelerator_config, "core_count", 2)
    }
  }

}
