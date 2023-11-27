locals {
  disk_type_condition = var.disk_type == "SSD Persistent Disk" ? "pd-ssd" : var.disk_type == "Standard Persistent Disk" ? "pd-standard" : ""
  admin_SSH_key_condition = var.admin_SSH_key != "" ? true : false
}

resource "google_compute_address" "member_ip_address" {
  name = "${var.member_name}-address"
  region = var.region
}

resource "google_compute_instance" "cluster_member" {
  name = var.member_name
  description = "CloudGuard Highly Available Security Cluster"
  zone = var.zone
  tags = [
    "http-server",
    "https-server",
    "checkpoint-gateway"
    ]
  machine_type = var.machine_type
  can_ip_forward = true

  boot_disk {
    auto_delete = true
    device_name = "${var.prefix}-boot"

    initialize_params {
      size = var.disk_size
      type = local.disk_type_condition
      image = "checkpoint-public/${var.image_name}"
    }
  }

  network_interface {
    network = var.cluster_network
    subnetwork = var.cluster_network_subnetwork
    network_ip = var.cluster_ip
  }
  network_interface {
    network = var.mgmt_network
    subnetwork = var.mgmt_network_subnetwork
    network_ip = var.mgmt_ip
    access_config {
      nat_ip = google_compute_address.member_ip_address.address
    }
  }
  dynamic "network_interface" {
    for_each = var.num_internal_networks >= 1 ? [
      1] : []
    content {
      network = var.internal_network1_network
      subnetwork = var.internal_network1_subnetwork
      network_ip = var.internal_network1_ip
    }
  }
  dynamic "network_interface" {
    for_each = var.num_internal_networks >= 2 ? [
      1] : []
    content {
      network = var.internal_network2_network
      subnetwork = var.internal_network2_subnetwork
    }
  }
  dynamic "network_interface" {
    for_each = var.num_internal_networks >= 3 ? [
      1] : []
    content {
      network = var.internal_network3_network
      subnetwork = var.internal_network3_subnetwork
    }
  }
  dynamic "network_interface" {
    for_each = var.num_internal_networks >= 4 ? [
      1] : []
    content {
      network = var.internal_network4_network
      subnetwork = var.internal_network4_subnetwork
    }
  }
  dynamic "network_interface" {
    for_each = var.num_internal_networks >= 5 ? [
      1] : []
    content {
      network = var.internal_network5_network
      subnetwork = var.internal_network5_subnetwork
    }
  }
  dynamic "network_interface" {
    for_each = var.num_internal_networks == 6 ? [
      1] : []
    content {
      network = var.internal_network6_network
      subnetwork = var.internal_network6_subnetwork
    }
  }

  service_account {

    scopes = [
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/cloudruntimeconfig"]
  }

  metadata = local.admin_SSH_key_condition ? {
    instanceSSHKey = var.admin_SSH_key
    adminPasswordSourceMetadata = var.generate_password ? var.generated_admin_password : ""
  } : { adminPasswordSourceMetadata = var.generate_password ? var.generated_admin_password : "" }

  metadata_startup_script = templatefile("${path.module}/startup-script.sh", {
    // script's arguments
    generatePassword = var.generate_password
    config_url = "https://runtimeconfig.googleapis.com/v1beta1/projects/${var.project}/configs/${var.prefix}-config"
    config_path = "projects/${var.project}/configs/${var.prefix}-config"
    sicKey = var.sic_key
    allowUploadDownload = var.allow_upload_download
    templateName = "cluster_tf"
    templateVersion = "20230622"
    templateType = "terraform"
    mgmtNIC = "eth0"
    hasInternet = "true"
    enableMonitoring = var.enable_monitoring
    shell = var.admin_shell
    installationType = "Cluster"
    computed_sic_key = ""
    managementGUIClientNetwork = ""
    primary_cluster_address_name = var.primary_cluster_address_name
    secondary_cluster_address_name = var.secondary_cluster_address_name
    managementNetwork = var.management_network
    numAdditionalNICs = var.num_internal_networks
    smart_1_cloud_token = "${var.member_name}" == "${var.prefix}-member-a" ? var.smart_1_cloud_token_a : var.smart_1_cloud_token_b
    name = var.member_name
    zoneConfig = var.zone
    region = var.region
  })
}