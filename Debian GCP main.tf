provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

resource "google_container_cluster" "example_cluster" {
  name     = "example-cluster"
  location = "us-central1-a"
  initial_node_count = 1

  node_config {
    machine_type = "n1-standard-1"
    disk_size_gb = 10
  }
}

resource "google_container_node_pool" "example_pool" {
  name       = "example-pool"
  cluster    = google_container_cluster.example_cluster.name
  node_count = 1
  version    = "latest"

  node_config {
    preemptible  = false
    machine_type = "n1-standard-1"
    disk_size_gb = 10
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_container_node_pool" "example_node_pool" {
  name       = "example-node-pool"
  cluster    = google_container_cluster.example_cluster.name
  node_count = 1
  version    = "latest"

  node_config {
    preemptible  = false
    machine_type = "n1-standard-1"
    disk_size_gb = 10
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_container_node_pool" "example_node_pool" {
  name       = "example-node-pool"
  cluster    = google_container_cluster.example_cluster.name
  node_count = 1
  version    = "latest"

  node_config {
    preemptible  = false
    machine_type = "n1-standard-1"
    disk_size_gb = 10
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
