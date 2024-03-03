
terraform {
  required_providers {
    provider = { source = "dmacvicar/libvirt" }
  }
}

provider "provider" {
  uri = "qemu:///system"
}

provider "provider" {
  alias = "swole"
  uri   = "qemu+ssh://pete@swole.mac.wales/system"
}

provider "provider" {
  alias = "smol"
  uri   = "qemu+ssh://pete@smol.mac.wales/system"
}

module "libvirt_domain_smol" {
  source = "./modules/terraform-module-libvirt-domain"

  providers = { libvirt = provider.smol }

  for_each = { for k,v in var.cluster: k => v if v.kvm_host == "smol" }

  guest_name           = "${each.key}"
  vcpu                 = "${each.value.vcpu}"
  memory               = "${each.value.memory}"
  network_name         = "bridge"
  subnet_type          = "static"
  ip_address           = "${each.value.ip_address}"
  gateway_address      = "192.168.1.254"
  dns_server           = "1.1.1.1"
  base_volume_name     = "rocky-base-9.2"
  base_volume_size     = "${each.value.base_volume_size}"
  cloud_init_user_data = file("${path.module}/cloud-init/user-data")
}

module "libvirt_domain_swole" {
  source = "./modules/terraform-module-libvirt-domain"

  providers = { libvirt = provider.swole }

  for_each = { for k,v in var.cluster: k => v if v.kvm_host == "swole" }

  guest_name           = "${each.key}"
  vcpu                 = "${each.value.vcpu}"
  memory               = "${each.value.memory}"
  network_name         = "bridge"
  subnet_type          = "static"
  ip_address           = "${each.value.ip_address}"
  gateway_address      = "192.168.1.254"
  dns_server           = "1.1.1.1"
  base_volume_name     = "rocky-base-9.2"
  base_volume_size     = "${each.value.base_volume_size}"
  cloud_init_user_data = file("${path.module}/cloud-init/user-data")
}
