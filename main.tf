terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "/home/statsenko/authorized_key.json"
  cloud_id = "b1gsgg4clk7akj1ua1r8"
  folder_id = "b1g4p1tpegmspupop7vk"
}