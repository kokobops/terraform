output "account_id" {
  value = "${yandex_compute_instance.test-vm.service_account_id}"
}

output "zone_id" {
  value = "${yandex_compute_instance.test-vm.zone}"
}

output "external_ip_address" {
  value = "${yandex_compute_instance.test-vm.network_interface.0.nat_ip_address}"
}

output "internal_subnet" {
  value = "${yandex_compute_instance.test-vm.network_interface.0.subnet_id}"
}
