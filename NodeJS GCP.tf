# Fichier main.tf

provider "google" {
  credentials = file("path/to/service-account-key.json")
  project     = "my-project"
  region      = "us-central1"
}

resource "google_project" "example" {
  name       = "my-project"
  project_id = "my-project"
}

resource "google_container_registry_repository" "example" {
  name = "my-repo"
}

resource "google_cloud_run_service" "example" {
  name     = "my-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/my-project/my-repo:latest"
        ports {
          container_port = 80
        }
      }
    }
  }
}
