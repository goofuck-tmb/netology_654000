variable "disks_params" {
  type = map(object({
    block_size = number
    pci_topology = string
    size = number
    type = string
  }))
  default = {
    v1 = { block_size = 4096, pci_topology = "PCI_TOPOLOGY_V1", size = 1, type = "network-hdd" }
  }
}

variable "disks_count" {
  type    = number
  default = 3
}

resource "yandex_compute_disk" "disk" {
  count = var.disks_count
  block_size = var.disks_params.v1.block_size
  hardware_generation {
    legacy_features {
      pci_topology = var.disks_params.v1.pci_topology
    }
  }
  name = "disk-${count.index + 1}"
  size = var.disks_params.v1.size
  type = var.disks_params.v1.type
}


resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.platform_id

  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk

    content {
      disk_id = secondary_disk.value.id
    }
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_web_nat
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_key}"
  }
}