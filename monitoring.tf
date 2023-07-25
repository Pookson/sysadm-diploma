resource "yandex_compute_instance" "zabbix-vm" {
  name = "zabbix-vm"
  zone = "ru-central1-c"

  resources {
    core_fraction = 20
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd8tf1sepeiku6d37l4l"
      size = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-3.id
    nat       = true
    ip_address = "192.168.30.30"
  }
  
  metadata = {
    user-data = "${file("./meta_zabbix.yml")}"
  }

}