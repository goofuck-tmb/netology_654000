resource "null_resource" "ansible_run" {
  triggers = {
    always_run = timestamp()
  }

  depends_on = [local_file.ansible_templatefile]

  provisioner "local-exec" {
    command = "ansible-playbook -i ${abspath(path.module)}/ansible.ini playbook.yml"
  }
  #  provisioner "local-exec" {
  #  command = "echo inventory ready: ${abspath(path.module)}/ansible.ini"
  #}
}