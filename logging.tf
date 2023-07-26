resource "yandex_compute_instance" "elasticsearch-vm" {
  name = "elasticsearch-vm"
  zone = "ru-central1-c"

  resources {
    core_fraction = 20
    cores  = 2
    memory = 4
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
    ip_address = "192.168.30.10"
  }
  
  metadata = {
    user-data = "${file("./meta_elasticsearch.yml")}"
  }

}

resource "yandex_compute_instance" "kibana-vm" {
  name = "kibana-vm"
  zone = "ru-central1-c"

  resources {
    core_fraction = 20
    cores  = 2
    memory = 4
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
    ip_address = "192.168.30.20"
  }
  
  metadata = {
    user-data = "${file("./meta_kibana.yml")}"
  }

}

