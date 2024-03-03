
variable "cluster" {
  type = map(any)
  default = {
    server1 = {
      ip_address       = "192.168.1.41" 
      vcpu             = 2
      memory           = 2048
      base_volume_size = 20 * 1073741824
      kvm_host         = "smol"
    }
    server2 = {
      ip_address       = "192.168.1.42" 
      vcpu             = 2
      memory           = 2048
      base_volume_size = 20 * 1073741824
      kvm_host         = "smol"
    }
    server3 = {
      ip_address       = "192.168.1.43" 
      vcpu             = 2
      memory           = 2048
      base_volume_size = 20 * 1073741824
      kvm_host         = "swole"
    }
    server4 = {
      ip_address       = "192.168.1.44" 
      vcpu             = 2
      memory           = 2048
      base_volume_size = 20 * 1073741824
      kvm_host         = "swole"
    }
  }
}

variable "libvirt_uri" {
  type    = string
  default = "qemu:///system"
}

variable "storage_pool" {
  type    = string
  default = "filesystems"
}
