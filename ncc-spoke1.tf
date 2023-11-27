resource "google_compute_address" "addr_intf_0" {
  name         = "gwa-interface-addr"
  region       = var.region
  subnetwork   = google_compute_subnetwork.new_subnet_0.name
  address_type = "INTERNAL"
  address      = "${var.new_subnet_0_str[0]}250"
  depends_on = [ 
                google_compute_network.new_net_0,
                google_compute_network.new_net_1,
                google_compute_subnetwork.new_subnet_0,
                google_compute_subnetwork.new_subnet_1
  ]
}

resource "google_compute_address" "addr_intf_1" {
  name         = "gwb-interface-addr"
  region       = var.region
  subnetwork   = google_compute_subnetwork.new_subnet_0.name
  address_type = "INTERNAL"
  address      = "${var.new_subnet_0_str[0]}251"
  depends_on = [
              google_compute_network.new_net_0,
              google_compute_network.new_net_1,
              google_compute_subnetwork.new_subnet_0,
              google_compute_subnetwork.new_subnet_1
  ]
}

resource "google_network_connectivity_hub" "new_ncc" {
  project     = var.project
  name        = var.ncc_hub_name
  description = "Created by Check Point NCC module."

  depends_on = [ google_compute_network.new_net_0,
                google_compute_network.new_net_1,
                module.member_a,
                module.member_b
               ]
}
resource "google_network_connectivity_spoke" "chkp1" {
  project  = var.project
  name     = "${var.ncc_hub_name}-spoke-chkp-1"
  location = var.region
  hub      = google_network_connectivity_hub.new_ncc.id
linked_router_appliance_instances {
    instances {
        virtual_machine = module.member_a.cluster_member_selflink
        ip_address = module.member_a.cluster_member_interal_ip
       }
    instances{
        virtual_machine = module.member_b.cluster_member_selflink
        ip_address = module.member_b.cluster_member_interal_ip
    }
    site_to_site_data_transfer = true
  }
  depends_on = [ google_compute_network.new_net_0,
                google_compute_network.new_net_1,
                module.member_a,
                module.member_b,
                google_network_connectivity_hub.new_ncc
              ]
}

module "cloud_router1" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 5.1"

  name    = "spoke1-router"
  project = var.project
  region  = var.region
  network = google_compute_network.new_net_0.name
  bgp = {
    asn               = 65000
    advertised_groups = ["ALL_SUBNETS"]
  }
  depends_on = [
    google_compute_network.new_net_0
  ]
}

resource "google_compute_router_interface" "routeriface_1" {
  name        = "gwa-interface"
  router      = "spoke1-router"
  region      = var.region
  project     = var.project
  private_ip_address = google_compute_address.addr_intf_0.address
  subnetwork  = google_compute_subnetwork.new_subnet_0.self_link
  depends_on = [ 
    google_compute_address.addr_intf_0,
    google_compute_network.new_net_0,
    google_compute_subnetwork.new_subnet_0
  ]
}

resource "google_compute_router_interface" "routeriface_2" {
  name        = "gwb-interface"
  router      = "spoke1-router"
  region      = var.region
  project     = var.project
  private_ip_address = google_compute_address.addr_intf_1.address
  subnetwork  = google_compute_subnetwork.new_subnet_0.self_link
  redundant_interface = google_compute_router_interface.routeriface_1.name
  depends_on = [ 
    google_compute_address.addr_intf_1,
    google_compute_network.new_net_0,
    google_compute_subnetwork.new_subnet_0,
    google_compute_router_interface.routeriface_1
  ]
}

resource "google_compute_router_peer" "peer1a" {
  name                      = "peera-1"
  router                    = "spoke1-router"
  region                    = var.region
  interface                 = google_compute_router_interface.routeriface_1.name
  router_appliance_instance = module.member_a.cluster_member_selflink
  peer_asn                  = 65001
  peer_ip_address           = module.member_a.cluster_member_interal_ip
  depends_on = [
    module.member_a,
    google_compute_router_interface.routeriface_1
  ]
}
resource "google_compute_router_peer" "peer1b" {
  name                      = "peera-2"
  router                    = "spoke1-router"
  region                    = var.region
  interface                 = google_compute_router_interface.routeriface_2.name
  router_appliance_instance = module.member_a.cluster_member_selflink
  peer_asn                  = 65001
  peer_ip_address           = module.member_a.cluster_member_interal_ip
  depends_on = [
    module.member_a,
    google_compute_router_interface.routeriface_2
  ]
}
resource "google_compute_router_peer" "peer2a" {
  name                      = "peerb-1"
  router                    = "spoke1-router"
  region                    = var.region
  interface                 = google_compute_router_interface.routeriface_2.name
  router_appliance_instance = module.member_b.cluster_member_selflink
  peer_asn                  = 65001
  peer_ip_address           = module.member_b.cluster_member_interal_ip
  depends_on = [
    module.member_b,
    google_compute_router_interface.routeriface_2
  ]
}
resource "google_compute_router_peer" "peer2b" {
  name                      = "peerb-2"
  router                    = "spoke1-router"
  region                    = var.region
  interface                 = google_compute_router_interface.routeriface_1.name
  router_appliance_instance = module.member_b.cluster_member_selflink
  peer_asn                  = 65001
  peer_ip_address           = module.member_b.cluster_member_interal_ip
  depends_on = [
    module.member_b,
    google_compute_router_interface.routeriface_1
  ]
}
