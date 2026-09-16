###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_zone-b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr-b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vpc_name-b" {
  type        = string
  default     = "develop-b"
  description = "VPC network & subnet name"
}


###ssh vars

# задание 6: ssh-ключ теперь литералом внутри переменной metadata, отдельная переменная не нужна
# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkOtYnZ666JbfiOtz/zjwMhDHz7u9qqBcheCGlziHs0mWq2SOMZTVeCsG/vZbxCpavx2TYW6lki4uEl5B6Ys7YUMlV1Eczh2Je+VLj86MOY9XOWg9ovKzbW3/EUDBDyQ8J17YtRiZ6mOY9HyjVAN9dTUQO0fXps8DxDDh846PJFU89rQU3uDiYSbUhXUNQqYhNJyPQRayH2Cfm6GTJNhg9/S+qCWyryVpZ6Sy3wgsvXayHEBK57+HZaCUnKM9Vl94SPLXKsiDK781MgE+cZB5/Zmvd9CxbCnPNWFLlSvy/INGy5vhxLObd5K6Y0OA5h+txsBksMOsjRWkLu6ejHAux"
#   description = "ssh-keygen -t ed25519"
# }

variable "env" {
  type    = string
  default = "develop"
}

variable "project" {
  type    = string
  default = "platform"
}

   variable "test" {
     type = list(map(list(string)))
   }