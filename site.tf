resource "yandex_compute_instance" "website-vm1" {
  name = "website-vm1"
  zone = "ru-central1-a"

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8tf1sepeiku6d37l4l"
      size = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1-internal.id
    ip_address = "192.168.10.10"
  }
  
  metadata = {
    user-data = "${file("./meta_website.yml")}"
  }

}

resource "yandex_compute_instance" "website-vm2" {
  name = "website-vm2"
  zone = "ru-central1-b"

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8tf1sepeiku6d37l4l"
      size = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-2-internal.id
    ip_address = "192.168.20.10"
  }
  
  metadata = {
    user-data = "${file("./meta_website.yml")}"
  }

}