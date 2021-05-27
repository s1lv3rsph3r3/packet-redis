resource "digitalocean_droplet" "green" {
  count = var.server_count
  image = "ubuntu-20-04-x64"
  name = "redis-green-version-1.0-${count.index}"
  region = "fra1"
  size = "s-1vcpu-1gb"
  private_networking = true
  tags = ["redis_v1_0", "green_v1_0"]
  ssh_keys = [29902027]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = var.pvt_key
    timeout = "2m"
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key_file} ./playbooks/server-setup.yml"
  }
}