provider "google" {
#   credentials = file("mygcp-creds.json")
  project     = "rugged-matrix-429710-t2"
  region      = "us-west1"
  zone        = "us-west1-b"

}

resource "google_compute_instance" "my_server" {
  name         = "my-gcp-server"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20240709"
    }
  }

  network_interface {
    network = "default"
  }
}
