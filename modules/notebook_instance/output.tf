output "notebook_instance_id_map" {
  value = tomap({
    for key, _ in var.notebook_environment_config.instance_config : key => google_notebooks_instance.nb_instance[key].id
  })
}

output "notebook_instance_uri_map" {
  value = tomap({
    for key, _ in var.notebook_environment_config.instance_config : key => google_notebooks_instance.nb_instance[key].proxy_uri
  })
}
