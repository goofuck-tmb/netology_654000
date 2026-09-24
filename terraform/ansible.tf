resource "local_file" "ansible_templatefile" {
  content = templatefile("${path.module}/ansible.tftpl", {
  webservers = yandex_compute_instance.web
  databases  = values(yandex_compute_instance.db)
  storage    = [yandex_compute_instance.storage]
})
  filename = "${abspath(path.module)}/ansible.ini"
}

