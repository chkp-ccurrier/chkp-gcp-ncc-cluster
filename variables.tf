variable "service_account_path" {
  type = string
  description = "User service account path in JSON format - From the service account key page in the Cloud Console choose an existing account or create a new one. Next, download the JSON key file. Name it something you can remember, store it somewhere secure on your machine, and supply the path to the location is stored."
  default = "../serv-accnt.json"
}
variable asg {
  type = string
  description = "Deploy an AutoScaling configuration"
  default = ""
}
variable ha {
  type = string
  description = "Deploy a ha configuration"
  default = ""
}
variable server {
  type = string
  description = "Deploy a single GW configuration"
  default = ""
}
variable "project" {
  type = string
  description = "Personal project id. The project indicates the default GCP project all of your resources will be created in."
  default = ""
}
variable "ncc_hub_name" {
  type = string
  description = "The name of the Network connectivity hub."
  default = "NCC-example-Hub"
}
variable "region" {
  type = string
  description = "The region determines what computing resources are available and where your data is stored and used"
  default = "us-central1"
}
variable "region2" {
  type = string
  description = "The region determines what computing resources are available and where your data is stored and used"
  default = "us-east5"
}
variable "mgmt_region" {
  type = string
  description = "The region for Management "
  default = "us-east4"
}
variable "mgmt_zone" {
  type = string
  description = "The zone determines what computing resources are available and where your data is stored and used"
  default = "us-east4-a"
}
variable "zone" {
  type = string
  description = "The zone determines what computing resources are available and where your data is stored and used"
  default = "us-central1-a"
}
variable "zoneA" {
  type = string
  description = "The zone determines what computing resources are available and where your data is stored and used"
  default = "us-central1-a"
}
variable "zoneB" {
  type = string
  description = "The zone determines what computing resources are available and where your data is stored and used"
  default = "us-central1-b"
}
variable "zoneC" {
  type = string
  description = "The zone determines what computing resources are available and where your data is stored and used"
  default = "us-east1-a"
}
variable "zoneD" {
  type = string
  description = "The zone determines what computing resources are available and where your data is stored and used"
  default = "us-east1-c"
}
variable "management_name" {
  type = string
  description = "The name of the Security Management Server as appears in autoprovisioning configuration. (Please enter a valid Security Management name including ascii characters only)"
  default = "ncc-checkpoint-management"
}
variable "image_name" {
  type = string
  description = "The HA gateway and management image name"
}
variable "image_single_name" {
  type = string
  description = "The single gateway and management image name"
}
variable "installationType" {
  type = string
  description = "Installation type and version"
  default = "Gateway only"
}
variable "gw_installationType" {
  type = string
  description = "Installation type and version"
  default = "Gateway only"
}
variable "license" {
  type = string
  description = "Checkpoint license (BYOL or PAYG)."
  default = "BYOL"
}
variable "prefix" {
  type = string
  description = "(Optional) Resources name prefix"
  default = "ncc-chkp-tf-"
}
variable "machine_type" {
  type = string
  default = "n1-standard-4"
}
variable "network" {
  type = list(string)
  description = "The network determines what network traffic the instance can access"
  default = ["default"]
}
variable "subnetwork" {
  type = list(string)
  description = "Assigns the instance an IPv4 address from the subnetwork’s range. Instances in different subnetworks can communicate with each other using their internal IPs as long as they belong to the same network."
  default = ["default"]
}
variable "network_enableTcp" {
  type = bool
  description = "Allow TCP traffic from the Internet"
  default = false
}
variable "network_tcpSourceRanges" {
  type = list(string)
  description = "Allow TCP traffic from the Internet"
  default = []
}
variable "network_enableGwNetwork" {
  type = bool
  description = "This is relevant for Management only. The network in which managed gateways reside"
  default = false
}
variable network_gwNetworkSourceRanges{
  type = list(string)
  description = "Allow TCP traffic from the Internet"
  default = []
}
variable "network_enableIcmp" {
  type = bool
  description ="Allow ICMP traffic from the Internet"
  default = false
}
variable "network_icmpSourceRanges" {
  type = list(string)
  description = "(Optional) Source IP ranges for ICMP traffic - Traffic is only allowed from sources within these IP address ranges. Use CIDR notation when entering ranges. Please leave empty list to unable ICMP traffic."
  default = []
}
variable network_enableUdp{
  type = bool
  description ="Allow UDP traffic from the Internet"
  default = false
}
variable "network_udpSourceRanges" {
  type = list(string)
  description = "(Optional) Source IP ranges for UDP traffic - Traffic is only allowed from sources within these IP address ranges. Use CIDR notation when entering ranges. Please leave empty list to unable UDP traffic."
  default = []
}
variable "network_enableSctp" {
  type = bool
  description ="Allow SCTP traffic from the Internet"
  default = false
}
variable "network_sctpSourceRanges" {
  type = list(string)
  description = "(Optional) Source IP ranges for SCTP traffic - Traffic is only allowed from sources within these IP address ranges. Use CIDR notation when entering ranges. Please leave empty list to unable SCTP traffic."
  default = []
}

variable "network_enableEsp" {
  type = bool
  description ="Allow ESP traffic from the Internet	"
  default = false
}
variable "network_espSourceRanges" {
  type = list(string)
  description = "(Optional) Source IP ranges for ESP traffic - Traffic is only allowed from sources within these IP address ranges. Use CIDR notation when entering ranges. Please leave empty list to unable ESP traffic."
  default = []
}
variable "diskType" {
  type = string
  description ="Disk type"
  default = "pd-ssd"
}
variable "bootDiskSizeGb" {
  type = number
  description ="Disk size in GB"
  default = 100
}
variable "generatePassword" {
  type = bool
  description ="Automatically generate an administrator password	"
  default = false
}
variable "management_nic" {
  type = string
  description = "Management Interface - Gateways in GCP can be managed by an ephemeral public IP or using the private IP of the internal interface (eth1)."
  default = "Ephemeral Public IP (eth0)"
}
variable "allowUploadDownload" {
  type = string
  description ="Allow download from/upload to Check Point"
  default = true
}
variable "enableMonitoring" {
  type = bool
  description ="Enable Stackdriver monitoring"
  default = false
}
variable "admin_shell" {
  type = string
  description = "Change the admin shell to enable advanced command line configuration."
  default = "/etc/cli.sh"
}
variable "admin_SSH_key" {
  type = string
  description = "(Optional) The SSH public key for SSH authentication to the template instances. Leave this field blank to use all project-wide pre-configured SSH keys."
  default = ""
}
variable "sicKey" {
  type = string
  description ="The Secure Internal Communication one time secret used to set up trust between the single gateway object and the management server"
  default = ""
}
variable "managementGUIClientNetwork" {
  type = string
  description ="Allowed GUI clients	"
  default = "0.0.0.0/0"
}
variable "numAdditionalNICs" {
  type = number
  description ="Number of additional network interfaces"
  default = 0
}
variable "externalIP" {
  type = string
  description = "External IP address type"
  default = "static"
}
variable "num_internal_networks" {
  type = number
  description = "A number in the range 1 - 6 of internal network interfaces."
  default = 1
}
variable "internal_network1_network" {
  type = list(string)
  description = "1st internal network ID in the chosen zone."
  default = ["ncc-int-traffic"]
}
variable "internal_network1_subnetwork" {
  type = list(string)
  description = "1st internal subnet ID in the chosen network."
  default = ["ncc-int-traffic-sub"]
}
variable "internal_network1_cidr" {
  type = list(string)
  description = "1st internal subnet CIDRS in the chosen network."
  default = []
}
variable "internal_network2_network" {
  type = list(string)
  description = "2nd internal network ID in the chosen zone."
  default = []
}
variable "internal_network2_subnetwork" {
  type = list(string)
  description = "2nd internal subnet ID in the chosen network."
  default = []
}
variable "internal_network2_cidr" {
  type = list(string)
  description = "2nd internal subnet CIDRS in the chosen network."
  default = []
}
variable "internal_network2_str" {
  type = list(string)
  description = "2nd internal subnet CIDR String in the chosen network."
  default = []
}
variable "internal_network3_network" {
  type = list(string)
  description = "3rd internal network ID in the chosen zone."
  default = []
}
variable "internal_network3_subnetwork" {
  type = list(string)
  description = "3rd internal subnet ID in the chosen network."
  default = []
}
variable "internal_network3_cidr" {
  type = list(string)
  description = "3rd internal subnet CIDRS in the chosen network."
  default = []
}
variable "internal_network4_network" {
  type = list(string)
  description = "4th internal network ID in the chosen zone."
  default = []
}
variable "internal_network4_subnetwork" {
  type = list(string)
  description = "4th internal subnet ID in the chosen network."
  default = []
}
variable "internal_network4_cidr" {
  type = list(string)
  description = "4th internal subnet CIDRS in the chosen network."
  default = []
}
variable "internal_network5_network" {
  type = list(string)
  description = "5th internal network ID in the chosen zone."
  default = []
}
variable "internal_network5_subnetwork" {
  type = list(string)
  description = "5th internal subnet ID in the chosen network."
  default = []
}
variable "internal_network5_cidr" {
  type = list(string)
  description = "5th internal subnet CIDRS in the chosen network."
  default = []
}
variable "internal_network6_network" {
  type = list(string)
  description = "6th internal network ID in the chosen zone."
  default = []
}
variable "internal_network6_subnetwork" {
  type = list(string)
  description = "6th internal subnet ID in the chosen network."
  default = []
}
variable "internal_network6_cidr" {
  type = list(string)
  description = "6th internal subnet CIDRS in the chosen network."
  default = []
}
variable "internal_network7_network" {
  type = list(string)
  description = "7th internal network ID in the chosen zone."
  default = []
}
variable "internal_network7_subnetwork" {
  type = list(string)
  description = "7th internal subnet ID in the chosen network."
  default = []
}
variable "internal_network7_cidr" {
  type = list(string)
  description = "7th internal subnet CIDRS in the chosen network."
  default = []
}
variable "internal_network8_network" {
  type = list(string)
  description = "8th internal network ID in the chosen zone."
  default = []
}
variable "internal_network8_subnetwork" {
  type = list(string)
  description = "8th internal subnet ID in the chosen network."
  default = []
}
variable "internal_network8_cidr" {
  type = list(string)
  description = "8th internal subnet CIDRS in the chosen network."
  default = []
}
variable "new_subnet_0_cidr" {
  type = list(string)
  default = []
}
variable "new_subnet_1_cidr" {
  type = list(string)
  default = []
}
variable "ha_vip" {
  type = string
  default = "2"
}
variable "ha_a_ip" {
  type = string
  default = "3"
}
variable "ha_b_ip" {
  type = string
  default = "4"
}
variable "new_subnet_0_str" {
  type = list(string)
  default = []
}
variable "new_subnet_1_str" {
  type = list(string)
  default = []
}
variable "mgmt_ip" {
  type = string
  default = "100"
}
variable "primary_cluster_address_name" {
  type    = string
  default = "vip-primary"
}
variable "secondary_cluster_address_name" {
  type = string
  default = "vip-secondary"
}
variable "smart_1_cloud_token_a" {
  type = string
  default = ""
}
variable "smart_1_cloud_token_b" {
  type = string
  default = ""
}