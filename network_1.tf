resource "google_compute_network" "new_net_0" {
  name          = var.network[0]
  project       = var.project
  routing_mode  = "GLOBAL"
  delete_default_routes_on_create = false
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "new_subnet_0" {
  name          = var.subnetwork[0]
  project       = var.project
  region        = var.region
  network       = var.network[0]
  ip_cidr_range = var.new_subnet_0_cidr[0]
  private_ip_google_access = true
}
resource "google_compute_subnetwork" "new_subnet_01" {
  name          = var.subnetwork[2]
  project       = var.project
  region        = var.region2
  network       =  var.network[0]
  ip_cidr_range = var.new_subnet_0_cidr[3]
  depends_on = [ 
              google_compute_network.new_net_0
  ]
}

resource "google_compute_network" "new_net_1" {
  name          = var.internal_network1_network[0]
  project       = var.project
  routing_mode  = "GLOBAL"
  delete_default_routes_on_create = false
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "new_subnet_1" {
  name          = var.internal_network1_subnetwork[0]
  project       = var.project
  region        = var.region
  network       = var.internal_network1_network[0]
  ip_cidr_range = var.new_subnet_0_cidr[1]
  private_ip_google_access = true
}

resource "google_compute_network" "new_net_2" {
  name          = var.network[1]
  project       = var.project
  routing_mode  = "GLOBAL"
  delete_default_routes_on_create = false
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "new_subnet_2" {
  name          = var.subnetwork[1]
  project       = var.project
  region        = var.region
  network       = google_compute_network.new_net_2.name
  ip_cidr_range = var.new_subnet_0_cidr[2]
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "mgmt_subnet_2" {
  name          = "${var.subnetwork[1]}-2"
  project       = var.project
  region        = var.region2
  network       = google_compute_network.new_net_2.name
  ip_cidr_range = var.new_subnet_0_cidr[3]
  private_ip_google_access = true
}

resource "google_compute_firewall" "new_net_0_fw_rules" {
  name          = "${var.network[0]}-rule"
  direction     = "INGRESS"
  network       = google_compute_network.new_net_0.name
  allow {
    protocol    = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "new_net_0_fw_rules-egress" {
  name          = "${var.network[0]}-rule-egresss"
  direction     = "EGRESS"
  network       = google_compute_network.new_net_0.name
  allow {
    protocol    = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "new_net_1_fw_rules" {
  name          = "${var.internal_network1_network[0]}-rule"
  direction     = "INGRESS"
  network       = google_compute_network.new_net_1.name
  allow {
    protocol    = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "new_net_1_fw_rules-egress" {
  name          = "${var.internal_network1_network[0]}-rule-egress"
  direction     = "EGRESS"
  network       = google_compute_network.new_net_1.name
  allow {
    protocol    = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}


resource "google_compute_firewall" "new_net_2_fw_rules" {
  name          = "${var.network[1]}-rule"
  direction     = "INGRESS"
  network       = google_compute_network.new_net_2.name
  allow {
    protocol    = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "new_net_2_fw_rules-egress" {
  name          = "${var.network[1]}-rule-egresss"
  direction     = "EGRESS"
  network       = google_compute_network.new_net_2.name
  allow {
    protocol    = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}