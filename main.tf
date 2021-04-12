module "network" {
  source  = "teamdatatonic/network/gcp"
  version = "1.2.6"

  project_id         = var.project_id
  environment_prefix = var.environment_prefix


  network_name = var.network_config.network_name
  subnets      = var.network_config.subnet_config_list
}



module "notebook_instance" {
  source = "./modules/notebook_instance"

  project_id                  = var.project_id
  project_number              = var.project_number
  region                      = var.region
  notebook_environment_config = var.notebook_environment_config

  network_name = module.network.network_self_link
  subnet_name  = module.network.subnet_url[0]

}
