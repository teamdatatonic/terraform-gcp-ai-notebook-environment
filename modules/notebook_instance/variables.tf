variable "project_id" {
  type = string
}

variable "project_number" {
  type = string
}

variable "region" {
  type = string
}

variable "network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "default_gpu_instance" {
  type    = string
  default = "NVIDIA_TELSA_P4"
}

variable "notebook_environment_config" {

}

variable "service_list" {
  type = list(string)
  default = [
    "notebooks"
  ]
}
