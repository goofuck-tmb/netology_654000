# ДЗ №2. Основы работы с Terraform

## Задание 1
Создал сервисный аккаунт с ролью editor и ключ, добавил свой ssh-ключ, поднял ВМ.

Намеренная ошибка: в `main.tf` было `platform_id = "standart-v4"` — две опечатки: `standart` вместо `standard` и несуществующая версия `v4`. Исправил на `standard-v3`. На `plan` не ловится, вылезает только на `apply`:
```
Error: ... rpc error: code = FailedPrecondition desc = Platform "standart-v4" not found
```

`preemptible = true` и `core_fraction` — для экономии в учёбе. Preemptible-машина дешевле, но облако может остановить её в любой момент (живёт до 24 часов). `core_fraction` — гарантированная доля vCPU (20%), платишь только за часть ядра. Для учебной ВМ надёжность и полная мощность не нужны, зато грант расходуется медленнее.

Скриншоты: `screenshots/1.png` (ВМ с внешним IP), `screenshots/2.png` (ssh + `curl ifconfig.me` с тем же IP).

## Задание 2
Хардкод-значения ресурсов вынес в переменные с префиксом `vm_web_`. Например:
```hcl
# main.tf — было → стало
platform_id = "standard-v3"   →   platform_id = var.vm_web_platform_id

# variables.tf
variable "vm_web_platform_id" {
  type    = string
  default = "standard-v3"
}
```
`terraform plan` — No changes.

## Задание 3
Переменные первой ВМ перенёс в `vms_platform.tf`. Добавил вторую ВМ (db) в зоне `ru-central1-b` и отдельную подсеть `develop-b` для неё:
```hcl
resource "yandex_vpc_subnet" "develop-b" {
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["10.0.2.0/24"]
  network_id     = yandex_vpc_network.develop.id
}

resource "yandex_compute_instance" "platform_db" {
  name = local.vm_db_name
  zone = var.vm_db_zone            # ru-central1-b
  # ...
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
  }
}
```

## Задание 4
Один `output` на обе ВМ. Результат `terraform output`:
```
zadanie-4 = {
  "db" = {
    "external_ip"   = "89.169.174.169"
    "fqdn"          = "epdk7p6pi0p9bdsoc68c.auto.internal"
    "instance_name" = "netology-develop-platform-db"
  }
  "web" = {
    "external_ip"   = "51.250.12.190"
    "fqdn"          = "fhman9gcsm8af3gdk2vo.auto.internal"
    "instance_name" = "netology-develop-platform-web"
  }
}
```

## Задание 5
В `locals.tf` имя каждой ВМ собрано интерполяцией из переменных `env` и `project`:
```hcl
locals {
  vm_web_name = "netology-${var.env}-${var.project}-web"
  vm_db_name  = "netology-${var.env}-${var.project}-db"
}
```

## Задание 6
`cores`/`memory`/`core_fraction` свернул в map-переменную `vms_resources`, а `metadata` — в общую переменную для обеих ВМ:
```hcl
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = { cores = 2, memory = 1, core_fraction = 20 }
    db  = { cores = 2, memory = 2, core_fraction = 20 }
  }
}

variable "metadata" {
  type = map(string)
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-rsa AAAA..."
  }
}
```
Использование в ресурсе:
```hcl
resources {
  cores         = var.vms_resources.web.cores
  memory        = var.vms_resources.web.memory
  core_fraction = var.vms_resources.web.core_fraction
}
metadata = var.metadata
```
Неиспользуемые переменные (`vm_web_cores`, `vm_db_memory` и т.д.) закомментировал. `terraform plan` — No changes.

## Задание 7 (*)
```
> local.test_list[1]
"staging"

> length(local.test_list)
3

> local.test_map.admin
"John"

> "${local.test_map.admin} is ${keys(local.test_map).0} for ${keys(local.servers).1} server based on OS ${local.servers.stage.image} with ${local.servers.production.cpu} v${keys(local.servers.production).0}, ${local.servers.production.ram} ${keys(local.servers.production).3} and ${length(local.servers.production.disks)} virtual ${keys(local.servers.production).1}"
"John is admin for production server based on OS ubuntu-20-04 with 10 vcpu, 40 ram and 4 virtual disks"
```

## Задание 8 (*)
Тип переменной:
```hcl
type = list(map(list(string)))
```
Извлечение нужной строки:
```
> var.test.0.dev1.0
"ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117"
```

---
Все ресурсы удалены (`terraform destroy`).
