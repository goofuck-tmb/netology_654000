  variable "platform_id" {
    type    = string
    default = "standard-v3"
  }


data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

locals {
  ssh_key = file("~/.ssh/id_rsa.pub")
}