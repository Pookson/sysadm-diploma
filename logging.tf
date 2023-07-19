/*
resource "yandex_compute_instance" "elasticsearch-vm" {
  name = "elasticsearch-vm"
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
    subnet_id = yandex_vpc_subnet.subnet-2.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta_log_elasticsearch.yml")}"
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
    subnet_id = yandex_vpc_subnet.subnet-2.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta_kibana.yml")}"
  }

}
*/