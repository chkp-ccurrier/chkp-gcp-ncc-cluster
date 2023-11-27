output "SIC_key" {
  value = var.sicKey
}
output "ManagementIP" {
  value = module.management.mgmt_ext_ip
}
output "member_a_name" {
  value = module.member_a.cluster_member_name
}
output "member_a_external_ip" {
  value = module.member_a.cluster_member_ip_address
}
output "spoke1_primary_cluster_Mgmt_Address" {
  value = google_compute_address.c1-primary_cluster_ip_ext_address.address
}
output "spoke1_secondary_cluster_Mgmt_Address" {
  value = google_compute_address.c1-secondary_cluster_ip_ext_address.address
}
output "member_b_name" {
  value = module.member_b.cluster_member_name
}
output "member_b_external_ip" {
  value = module.member_b.cluster_member_ip_address
}
output "spoke2_primary_cluster_Mgmt_Address" {
  value = google_compute_address.c2_primary_clus_ext_ip_addr.address
}
output "spoke2_secondary_cluster_Mgmt_Address" {
  value = google_compute_address.c2_secondary_clus_ext_ip_addr.address
}
output "member_s2a_name" {
  value = module.member_s2a.cluster_member_name
}
output "member_s2a_external_ip" {
  value = module.member_s2a.cluster_member_ip_address
}
output "member_s2b_name" {
  value = module.member_s2b.cluster_member_name
}
output "member_s2b_external_ip" {
  value = module.member_s2b.cluster_member_ip_address
}