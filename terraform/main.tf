terraform {
  required_version = ">= 0.14"

/*  backend "gcs" {
    bucket      = "qam-terraform-state"
    prefix      = "terraform/state"
  }
*/
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.81"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}


provider "google" {
/*  credentials = var.credentials
  project     = var.project
  region      = var.region
*/
  credentials = file("qam-project-331620-d0305e36e224.json")
  project     = var.project
  region      = var.region
}

resource "random_integer" "random-integer" {
  min = 1000000
  max = 9999999
}