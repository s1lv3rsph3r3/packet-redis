resource "digitalocean_vpc" "redis_example" {
  name   = "redis-example-project"
  region = "fra1"
  count = 1
}
