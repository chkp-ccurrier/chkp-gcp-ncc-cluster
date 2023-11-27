output "cluster_member_name" {
  value = google_compute_instance.cluster_member.name
}
output "cluster_member_ip_address" {
  value = google_compute_address.member_ip_address.address
}
output "cluster_member_selflink" {
  value = google_compute_instance.cluster_member.self_link
}
output "cluster_member_interal_ip" {
  value = google_compute_instance.cluster_member.network_interface[0].network_ip
}
