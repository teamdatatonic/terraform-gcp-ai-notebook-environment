terraform {
  required_version = ">= 0.14.3"

  required_providers {
    google = {
      version = "~> 3.31"
    }

    google-beta = {
      version = "~> 3.31"
    }
  }

}
