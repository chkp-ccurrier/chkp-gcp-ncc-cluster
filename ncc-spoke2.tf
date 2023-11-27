resource "google_compute_address" "s2-addr_intf_0" {
  name         = "s2-gw-interface-addr"
  region       = var.region2
  subnetwork   = google_compute_subnetwork.spoke_subnet_0.name
  address_type = "INTERNAL"
  address      = "${var.new_subnet_1_str[0]}250"
  depends_on = [ 
                google_compute_network.spoke_net_0,
                google_compute_network.spoke_net_1 ,
                google_compute_subnetwork.spoke_subnet_0,
                google_compute_subnetwork.spoke_subnet_1
  ]
}

resource "google_compute_address" "s2-addr_intf_1" {
  name         = "s2-gw-interface1-addr"
  region       = var.region2
  subnetwork   = google_compute_subnetwork.spoke_subnet_0.name
  address_type = "INTERNAL"
  address      = "${var.new_subnet_1_str[0]}251"
  depends_on = [ 
                google_compute_network.spoke_net_0,
                google_compute_network.spoke_net_1,
                google_compute_subnetwork.spoke_subnet_0,
                google_compute_subnetwork.spoke_subnet_1
  ]
}
resource "google_network_connectivity_spoke" "chkp2" {
  project  = var.project
  name     = "${var.ncc_hub_name}-spoke-chkp-2"
  location = var.region2
  hub      = google_network_connectivity_hub.new_ncc.id
linked_router_appliance_instances {
    instances {
        virtual_machine = module.member_s2a.cluster_member_selflink
        ip_address = module.member_s2a.cluster_member_interal_ip
    }
        instances {
        virtual_machine = module.member_s2b.cluster_member_selflink
        ip_address = module.member_s2b.cluster_member_interal_ip
    }
    site_to_site_data_transfer = false
  }
  depends_on = [ google_compute_network.spoke_net_0,
                google_compute_network.spoke_net_1,
                module.member_s2a,
                module.member_s2b,
                google_network_connectivity_hub.new_ncc
              ]
}

module "cloud_router2" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 5.1"

  name    = "spoke2-router"
  project = var.project
  region  = var.region2
  network = google_compute_network.spoke_net_0.name
  bgp = {
    asn               = 65100
    advertised_groups = ["ALL_SUBNETS"]
  }
  depends_on = [
    google_compute_network.spoke_net_0
  ]
}

resource "google_compute_router_interface" "s2-routeriface_1" {
  name        = "gw-interface"
  router      = "spoke2-router"
  region      = var.region2
  project     = var.project
  private_ip_address = google_compute_address.s2-addr_intf_0.address
  subnetwork  = google_compute_subnetwork.spoke_subnet_0.self_link
  depends_on = [ 
    google_network_connectivity_spoke.chkp2,
    google_compute_address.s2-addr_intf_0,
    google_compute_network.spoke_net_0,
    google_compute_subnetwork.spoke_subnet_0
  ]
}

resource "google_compute_router_interface" "s2-routeriface_2" {
  name        = "gw-interface1"
  router      = "spoke2-router"
  region      = var.region2
  project     = var.project
  private_ip_address = google_compute_address.s2-addr_intf_1.address
  subnetwork  = google_compute_subnetwork.spoke_subnet_0.self_link
  redundant_interface = google_compute_router_interface.s2-routeriface_1.name
  depends_on = [
    google_network_connectivity_spoke.chkp2,
    google_compute_address.s2-addr_intf_1,
    google_compute_subnetwork.spoke_subnet_0,
    google_compute_router_interface.s2-routeriface_1
  ]
}

resource "google_compute_router_peer" "s2-peer1" {
  name                      = "s2-peer1"
  router                    = "spoke2-router"
  region                    = var.region2
  interface                 = google_compute_router_interface.s2-routeriface_1.name
  router_appliance_instance = module.member_s2a.cluster_member_selflink
  peer_asn                  = 65010
  peer_ip_address           = "${var.new_subnet_1_str[0]}${var.ha_a_ip}"
  depends_on = [
    google_network_connectivity_spoke.chkp2,
    module.member_s2a,
    google_compute_router_interface.s2-routeriface_1,
    google_compute_router_interface.s2-routeriface_2
  ]
}
resource "google_compute_router_peer" "s2-peer2" {
  name                      = "s2-peer2"
  router                    = "spoke2-router"
  region                    = var.region2
  interface                 = google_compute_router_interface.s2-routeriface_2.name
  router_appliance_instance = module.member_s2a.cluster_member_selflink
  peer_asn                  = 65010
  peer_ip_address           = "${var.new_subnet_1_str[0]}${var.ha_a_ip}"
  depends_on = [
    google_network_connectivity_spoke.chkp2,
    module.member_s2a,
    google_compute_router_interface.s2-routeriface_1,
    google_compute_router_interface.s2-routeriface_2
  ]
}

resource "google_compute_router_peer" "s2-peer3" {
  name                      = "s2-peer3"
  router                    = "spoke2-router"
  region                    = var.region2
  interface                 = google_compute_router_interface.s2-routeriface_1.name
  router_appliance_instance = module.member_s2b.cluster_member_selflink
  peer_asn                  = 65010
  peer_ip_address           = "${var.new_subnet_1_str[0]}${var.ha_b_ip}"
  depends_on = [
    google_network_connectivity_spoke.chkp2,
    module.member_s2b.cluster_member_selflink,
    google_compute_router_interface.s2-routeriface_1,
    google_compute_router_interface.s2-routeriface_2
  ]
}
resource "google_compute_router_peer" "s2-peer4" {
  name                      = "s2-peer4"
  router                    = "spoke2-router"
  region                    = var.region2
  interface                 = google_compute_router_interface.s2-routeriface_2.name
  router_appliance_instance = module.member_s2b.cluster_member_selflink
  peer_asn                  = 65010
  peer_ip_address           = "${var.new_subnet_1_str[0]}${var.ha_b_ip}"
  depends_on = [
    google_network_connectivity_spoke.chkp2,
    module.member_s2b,
    google_compute_router_interface.s2-routeriface_1,
    google_compute_router_interface.s2-routeriface_2
  ]
}