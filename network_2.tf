resource "google_compute_network" "spoke_net_0" {
  name    = var.network[2]
  project = var.project
  routing_mode = "GLOBAL"
  auto_create_subnetworks = false
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "spoke_subnet_0" {
  name          = "${var.subnetwork[2]}-cent"
  project       = var.project
  region        = var.region2
  network       = google_compute_network.spoke_net_0.name
  ip_cidr_range = var.new_subnet_1_cidr[0]
  private_ip_google_access = true
  depends_on = [ 
              google_compute_network.spoke_net_0
  ]
}

resource "google_compute_network" "spoke_net_1" {
  name    = var.internal_network1_network[2]
  project = var.project
  routing_mode = "GLOBAL"
  delete_default_routes_on_create = false
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "spoke_subnet_1" {
  name          = var.internal_network1_subnetwork[2]
  project       = var.project
  region        = var.region2
  network       = google_compute_network.spoke_net_1.name
  ip_cidr_range = var.new_subnet_1_cidr[2]
  private_ip_google_access = true
  depends_on = [ 
                google_compute_network.spoke_net_1
   ]
}

resource "google_compute_subnetwork" "spoke_subnet_2" {
  name          = var.subnetwork[3]
  project       = var.project
  region        = var.region2
  network       = google_compute_network.spoke_net_1.name
  ip_cidr_range = var.new_subnet_1_cidr[1]
  private_ip_google_access = true
  depends_on = [ 
                google_compute_network.spoke_net_1
   ]
}

resource "google_compute_firewall" "spoke_net_0_fw_rules" {
  name = "${google_compute_network.spoke_net_0.name}-rule"
  direction = "INGRESS"
  network = google_compute_network.spoke_net_0.name
  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "spoke_net_0_fw_rules-egress" {
  name = "${google_compute_network.spoke_net_0.name}-rule-egresss"
  direction = "EGRESS"
  network = google_compute_network.spoke_net_0.name
  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "spoke_net_1_fw_rules" {
  name = "${google_compute_network.spoke_net_1.name}-rule"
  direction = "INGRESS"
  network = google_compute_network.spoke_net_1.name
  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "spoke_net_1_fw_rules-egress" {
  name = "${google_compute_network.spoke_net_1.name}-rule-egress"
  direction = "EGRESS"
  network = google_compute_network.spoke_net_1.name
  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}
