resource "random_pet" "nomad" {
  length = 1
}

provider "aws" {
  region = var.region

  allowed_account_ids = ["029718257588"]

  assume_role {
    role_arn = "arn:aws:iam::029718257588:role/go-agent"
  }
}


module "hashistack" {
  source = "../../modules/hashistack"

  name                   = "${var.name}-${random_pet.nomad.id}"
  region                 = var.region
  ami                    = var.ami
  server_instance_type   = var.server_instance_type
  client_instance_type   = var.client_instance_type
  key_name               = var.key_name
  server_count           = var.server_count
  client_count           = var.client_count
  retry_join             = var.retry_join
  nomad_binary           = var.nomad_binary
  root_block_device_size = var.root_block_device_size
  whitelist_ip           = var.whitelist_ip
}
