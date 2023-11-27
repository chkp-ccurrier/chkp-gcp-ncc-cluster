
resource "google_compute_address" "c1-primary_cluster_ip_ext_address" {
  name = "s1-${var.primary_cluster_address_name}"
  region = var.region
}

resource "google_compute_address" "c1-secondary_cluster_ip_ext_address" {
  name = "s1-${var.secondary_cluster_address_name}"
  region = var.region
}

module "member_a" {
  source = "./cluster-member"

  prefix = var.prefix
  member_name = "s1-${var.prefix}-member-a"
  region = var.region
  zone = var.zoneA
  machine_type = var.machine_type
  disk_size = var.bootDiskSizeGb
  disk_type = var.diskType
  image_name = var.image_name
  cluster_network = google_compute_network.new_net_0.name
  cluster_network_subnetwork = google_compute_subnetwork.new_subnet_0.name
  cluster_ip = "${var.new_subnet_0_str[0]}${var.ha_a_ip}"
  mgmt_network = google_compute_network.new_net_2.name
  mgmt_network_subnetwork = google_compute_subnetwork.new_subnet_2.name
  mgmt_ip = "${var.new_subnet_0_str[2]}${var.ha_a_ip}"
  num_internal_networks = var.numAdditionalNICs
  internal_network1_network = google_compute_network.new_net_1.name
  internal_network1_subnetwork = google_compute_subnetwork.new_subnet_1.name
  internal_network1_ip = "${var.new_subnet_0_str[1]}${var.ha_a_ip}"
  /*internal_network2_network = var.internal_network2_network
  internal_network2_subnetwork = var.internal_network2_subnetwork
  internal_network3_network = var.internal_network3_network
  internal_network3_subnetwork = var.internal_network3_subnetwork
  internal_network4_network = var.internal_network4_network
  internal_network4_subnetwork = var.internal_network4_subnetwork
  internal_network5_network = var.internal_network5_network
  internal_network5_subnetwork = var.internal_network5_subnetwork
  internal_network6_network = var.internal_network6_network
  internal_network6_subnetwork = var.internal_network6_subnetwork */
  admin_SSH_key = var.admin_SSH_key
  generated_admin_password = ""
  project = var.project
  generate_password = var.generatePassword
  sic_key = var.sicKey
  allow_upload_download = var.allowUploadDownload
  enable_monitoring = var.enableMonitoring
  admin_shell = var.admin_shell
  management_network = "${module.management.mgmt_ext_ip}/32"
  primary_cluster_address_name = google_compute_address.c1-primary_cluster_ip_ext_address.name
  secondary_cluster_address_name = google_compute_address.c1-secondary_cluster_ip_ext_address.name
  smart_1_cloud_token_a = var.smart_1_cloud_token_a
  smart_1_cloud_token_b = var.smart_1_cloud_token_b
  depends_on = [ google_compute_subnetwork.new_subnet_2,
                google_compute_subnetwork.new_subnet_1,
                google_compute_subnetwork.new_subnet_0,
                google_compute_subnetwork.spoke_subnet_1,
                google_compute_subnetwork.spoke_subnet_0
              ]
}

module "member_b" {
  source = "./cluster-member"

  prefix = var.prefix
  member_name = "s1-${var.prefix}-member-b"
  region = var.region
  zone = var.zoneB
  machine_type = var.machine_type
  disk_size = var.bootDiskSizeGb
  disk_type = var.diskType
  image_name = var.image_name
  cluster_network = google_compute_network.new_net_0.name
  cluster_network_subnetwork = google_compute_subnetwork.new_subnet_0.name
  cluster_ip = "${var.new_subnet_0_str[0]}${var.ha_b_ip}"
  mgmt_network = google_compute_network.new_net_2.name
  mgmt_network_subnetwork = google_compute_subnetwork.new_subnet_2.name
  mgmt_ip = "${var.new_subnet_0_str[2]}${var.ha_b_ip}"
  num_internal_networks = var.num_internal_networks
  internal_network1_network = google_compute_network.new_net_1.name
  internal_network1_subnetwork = google_compute_subnetwork.new_subnet_1.name
  internal_network1_ip = "${var.new_subnet_0_str[1]}${var.ha_b_ip}"
/*  internal_network2_network = var.internal_network2_network
  internal_network2_subnetwork = var.internal_network2_subnetwork
  internal_network3_network = var.internal_network3_network
  internal_network3_subnetwork = var.internal_network3_subnetwork
  internal_network4_network = var.internal_network4_network
  internal_network4_subnetwork = var.internal_network4_subnetwork
  internal_network5_network = var.internal_network5_network
  internal_network5_subnetwork = var.internal_network5_subnetwork
  internal_network6_network = var.internal_network6_network
  internal_network6_subnetwork = var.internal_network6_subnetwork */
  admin_SSH_key = var.admin_SSH_key
  generated_admin_password = ""
  project = var.project
  generate_password = var.generatePassword
  sic_key = var.sicKey
  allow_upload_download = var.allowUploadDownload
  enable_monitoring = var.enableMonitoring
  admin_shell = var.admin_shell
  management_network = "${module.management.mgmt_ext_ip}/32"
  primary_cluster_address_name = google_compute_address.c1-primary_cluster_ip_ext_address.name
  secondary_cluster_address_name = google_compute_address.c1-secondary_cluster_ip_ext_address.name
  smart_1_cloud_token_a = var.smart_1_cloud_token_a
  smart_1_cloud_token_b = var.smart_1_cloud_token_b
  depends_on = [ google_compute_subnetwork.new_subnet_2,
                google_compute_subnetwork.new_subnet_1,
                google_compute_subnetwork.new_subnet_0,
                google_compute_subnetwork.spoke_subnet_1,
                google_compute_subnetwork.spoke_subnet_0,
                module.member_a
              ]
}
