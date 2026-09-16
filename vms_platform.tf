# переменные из задания 2

variable "vm_web_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vm_web_platform_id" {
  type    = string
  default = "standard-v3"
}

# задание 6: заменено на vms_resources
# variable "vm_web_cores" {
#   type    = number
#   default = 2
# }

# variable "vm_web_memory" {
#   type    = number
#   default = 1
# }

# variable "vm_web_core_fraction" {
#   type    = number
#   default = 20
# }

variable "vm_web_preemptible" {
  type    = bool
  default = true
}

variable "vm_web_nat" {
  type    = bool
  default = true
}

# задание 6: заменено на metadata
# variable "vm_web_serial-port-enable" {
#   type    = number
#   default = 1
# }

# db

variable "vm_db_platform_id" {
  type    = string
  default = "standard-v3"
}

# задание 6: заменено на vms_resources
# variable "vm_db_cores" {
#   type    = number
#   default = 2
# }

# variable "vm_db_memory" {
#   type    = number
#   default = 2
# }

# variable "vm_db_core_fraction" {
#   type    = number
#   default = 20
# }

variable "vm_db_preemptible" {
  type    = bool
  default = true
}

variable "vm_db_nat" {
  type    = bool
  default = true
}

# задание 6: заменено на metadata
# variable "vm_db_serial-port-enable" {
#   type    = number
#   default = 1
# }

variable "vm_db_zone" {
  type    = string
  default = "ru-central1-b"
}

#zadanie6.1
variable "vms_resources" {
  type = map(object({
    cores = number
    memory = number
    core_fraction = number
  }))
  default = {
    db  = { cores = 2, memory = 2, core_fraction = 20 }
    web = { cores = 2, memory = 1, core_fraction = 20 }
  }
}

#6.2
variable "metadata" {
  type = map(string)
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkOtYnZ666JbfiOtz/zjwMhDHz7u9qqBcheCGlziHs0mWq2SOMZTVeCsG/vZbxCpavx2TYW6lki4uEl5B6Ys7YUMlV1Eczh2Je+VLj86MOY9XOWg9ovKzbW3/EUDBDyQ8J17YtRiZ6mOY9HyjVAN9dTUQO0fXps8DxDDh846PJFU89rQU3uDiYSbUhXUNQqYhNJyPQRayH2Cfm6GTJNhg9/S+qCWyryVpZ6Sy3wgsvXayHEBK57+HZaCUnKM9Vl94SPLXKsiDK781MgE+cZB5/Zmvd9CxbCnPNWFLlSvy/INGy5vhxLObd5K6Y0OA5h+txsBksMOsjRWkLu6ejHAux"
  }
}
