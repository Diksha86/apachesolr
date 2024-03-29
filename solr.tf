provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
}

//Solr Instance
resource "google_compute_address" "solrip" {
  name   = "${var.solr_instance_ip_name}"
  region = "${var.solr_instance_ip_region}"
}


resource "google_compute_instance" "apache-solr" {
  name         = "${var.instance_name}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["name", "solr", "http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  #scratch_disk {
  #}

  network_interface {
    network    = "${var.solrvpc}"
    subnetwork = "${var.solrsub}"
    access_config {
      // Ephemeral IP
      nat_ip = "${google_compute_address.solrip.address}"
    }
  }
  metadata = {
    name = "solr"
  }

  metadata_startup_script = "sudo apt-get update -y;sudo apt-get install git -y; sudo git clone https://github.com/Diksha86/apachesolr.git; cd apachesolr; sudo chmod 777 *;sudo sh solr.sh"
}
