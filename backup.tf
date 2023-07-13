/*
resource "yandex_compute_snapshot" "website-vm1-snap" {
  name = "website-vm1-snap"
  source_disk_id = "${yandex_compute_instance.website-vm1.boot_disk[0].disk_id}"
}

resource "yandex_compute_snapshot" "website-vm2-snap" {
  name = "website-vm2-snap"
  source_disk_id = "${yandex_compute_instance.website-vm2.boot_disk[0].disk_id}"
}
*/