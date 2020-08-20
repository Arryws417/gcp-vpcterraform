# create network

resource "google_compute_network" "mynetwork" {
  name                    = "mynetwork"
  auto_create_subnetworks  = true
}

# create firewall-rule

resource "google_compute_firewall" mynetwork-allow-http-ssh-icmp-rdp" {
  name    = "mynetwork-allow-http-ssh-icmp-rdp"
  network = google_compute_mynetwork.mynetwork.self_link
  allow {
    protocol  = "tcp"
    ports     = ["22, "80", "3389"]
    }
  allow {
    protocol  = "icmp"
    }
}

# create Virtual Machine in region US or other region

module  "mynet-us-vm" {
  
  source          = "./instance"
  instance_name   = "mynet-us-vm"
  instance_zone   = "us-central1-a"
  instance_subnetwork = google_compute_network.mynetwork.self_link
}

# create virtual machine in region EU or other region

module  "mynet-eu-vm" {
  source          = "./instance"
  instance_name   = "mynet-eu-vm"
  instance_zone   = "europe-west1-d"
  instance_subnetwork = google_compute_network.mynetwork.self_link 
}
