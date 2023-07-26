resource "yandex_compute_instance" "bastion-vm" {
  name = "bastion-vm"
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
    ip_address = "192.168.30.99"
  }
  
  metadata = {
    user-data = "${file("./meta_bastion.yml")}"
  }

}


resource "yandex_vpc_network" "network-1" {
  name = "network-1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet-1"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet-2"
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "subnet-3" {
  name           = "subnet-3"
  zone           = "ru-central1-c"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["192.168.30.0/24"]
}

resource "yandex_alb_target_group" "target-group" {
  name           = "target-group"

  target {
    subnet_id    = "${yandex_vpc_subnet.subnet-1.id}"
    ip_address   = "${yandex_compute_instance.website-vm1.network_interface.0.ip_address}"
  }

  target {
    subnet_id    = "${yandex_vpc_subnet.subnet-2.id}"
    ip_address   = "${yandex_compute_instance.website-vm2.network_interface.0.ip_address}"
  }

}

resource "yandex_alb_backend_group" "backend-group" {
  name      = "backend-group"

  http_backend {
    name = "http-backend"
    weight = 1
    port = 80
    target_group_ids = ["${yandex_alb_target_group.target-group.id}"]
    load_balancing_config {
      panic_threshold = 50
    }    
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15
      http_healthcheck {
        path               = "/"
        }
    }
  }
}


resource "yandex_alb_http_router" "http-router" {
  name   = "http-router"
  labels = {
    tf-label    = "tf-label-value"
    empty-label = ""
  }
}

resource "yandex_alb_virtual_host" "virtual-host" {
  name           = "virtual-host"
  http_router_id = yandex_alb_http_router.http-router.id
  route {
    name = "route-1"
    http_route {
        http_match {
            path {
                prefix = "/"
            }
        }
      http_route_action {
        backend_group_id = yandex_alb_backend_group.backend-group.id
        timeout          = "60s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "load-balancer" {
  name        = "load-balancer"

  network_id  = "${yandex_vpc_network.network-1.id}"

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet-1.id 
    }
  }

  listener {
    name = "listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }    
    http {
      handler {
        http_router_id = yandex_alb_http_router.http-router.id
      }
    }
  }
}  


