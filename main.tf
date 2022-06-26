variable "token" {
   type = string
}

provider "yandex" {
  token     = var.token
  cloud_id  = "b1guif57742i3jj2u5fk"
  folder_id = "b1ghp84ceh3vgfbcmrh2"
  zone      = "ru-central1-a"
}

resource "yandex_compute_image" "default" {
  name   = "ubuntu"
  source_image = "fd8kp2fgjvpphbbnn375"
}

resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "default" {
  name = "subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["172.16.0.0/24"]
}

resource "yandex_compute_instance" "test-vm" {
  name        = "test"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "${yandex_compute_image.default.id}"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat = true
  }

  metadata = {
    ssh-keys = "centos:${file("/home/centos/.ssh/id_rsa.pub")}"
  }
}