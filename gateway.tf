resource "digitalocean_droplet" "gateway_green" {
  count = 1
  image = "ubuntu-20-04-x64"
  name = "gateway-green-version-1.0-${count.index}"
  region = "fra1"
  size = "s-1vcpu-1gb"
  private_networking = true
  tags = ["gateway_v1_0", "green_v1_0"]
  ssh_keys = [29902027]
  vpc_uuid = digitalocean_vpc.redis_example.id
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = var.pvt_key
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt-get update",
      "sudo apt-get -y install nginx"
    ]
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key_file} ./playbooks/server-setup.yml"
  }
}
