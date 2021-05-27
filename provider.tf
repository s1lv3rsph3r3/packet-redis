terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.7.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}
variable "pvt_key_file" {}

variable "aws_region" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "uuid" {}
variable "server_count" {}

provider "digitalocean" {
  token = var.do_token
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "digitalocean_ssh_key" "enigma-ssh" {
  name = "enigma-ssh"
}

terraform {
  backend "s3" {
    bucket = "packet-redis-terraform-state"
    key = "default-infrastructure"
    region = "eu-west-1"
    profile = "default"
    encrypt = true
  }
}
