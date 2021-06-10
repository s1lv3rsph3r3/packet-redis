resource "digitalocean_firewall" "packet_redis" {
  name = "only-internal-traffic-please"

  droplet_ids = digitalocean_droplet.redis_green.*.id

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = [digitalocean_vpc.redis_example.ip_range]
  }

  inbound_rule {
    protocol = "tcp"
    port_range = "6379"
    source_addresses = [digitalocean_vpc.redis_example.ip_range]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
