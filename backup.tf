resource "yandex_compute_snapshot_schedule" "backup" {
  schedule_policy {
	expression = "30 23 ? * *"
  }

  snapshot_count = 1

  retention_period = "168h"

  snapshot_spec {
	  description = "daily snapshot"
  }

  disk_ids = ["${yandex_compute_instance.website-vm1.boot_disk[0].disk_id}", "${yandex_compute_instance.website-vm2.boot_disk[0].disk_id}", "${yandex_compute_instance.zabbix-vm.boot_disk[0].disk_id}", "${yandex_compute_instance.elasticsearch-vm.boot_disk[0].disk_id}", "${yandex_compute_instance.kibana-vm.boot_disk[0].disk_id}", "${yandex_compute_instance.bastion-vm.boot_disk[0].disk_id}"]
}