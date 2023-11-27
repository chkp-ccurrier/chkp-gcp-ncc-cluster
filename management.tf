resource "google_compute_network" "mgmt_net" {
  name          = "cp-management"
  project       = var.project
  routing_mode  = "GLOBAL"
  delete_default_routes_on_create = false
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "mgmt_sub" {
  name          = "manager-sub"
  project       = var.project
  region        = var.mgmt_region
  network       = google_compute_network.mgmt_net.name
  ip_cidr_range = "172.0.0.0/24"
  private_ip_google_access = true
}

resource "google_compute_firewall" "mgmt_fw_rule-ingress" {
  name          = "mgmt-rule-ingress"
  direction     = "INGRESS"
  network       = google_compute_network.mgmt_net.name
  allow {
    protocol    = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "mgmt_fw_rule-egress" {
  name          = "mgmt-rule-egresss"
  direction     = "EGRESS"
  network       = google_compute_network.mgmt_net.name
  allow {
    protocol    = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}

module "management" {
  source = "./mgmt"
  project                             = var.project
  service_account_path                = var.service_account_path
  naming_prefix                       = var.prefix
  image_name                          = "check-point-r8120-byol-631-991001383-v20230907" #"check-point-r8120-byol"
  mgmt_vpc                            = google_compute_network.mgmt_net.name
  mgmt_subnet                         = google_compute_subnetwork.mgmt_sub.name
  installationType                    = "Management only"
  license                             = var.license
  prefix                              = var.prefix
  management_nic                      = "Ephemeral Public IP (eth0)"
  admin_shell                         = var.admin_shell
  generatePassword                    = false
  allowUploadDownload                 = true
  ssh_key                             = var.admin_SSH_key
  managementGUIClientNetwork          = "0.0.0.0/0"
  region                              = var.mgmt_region
  zone                                = var.mgmt_zone
  externalIP                          = "static"
  mgmt_ip                             = "172.0.0.${var.mgmt_ip}"
  machine_type                        = var.machine_type
  diskType                            = var.diskType
  bootDiskSizeGb                      = var.bootDiskSizeGb
  enableMonitoring                    = false

  depends_on = [ 
                google_compute_network.mgmt_net,
                google_compute_subnetwork.mgmt_sub
              ]
}