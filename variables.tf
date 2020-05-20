variable "ibmcloud_api_key" {}
variable "machine_type" {
   default = "b3c.8x32"
}
variable "hardware" {
   default = "shared"
}

variable "datacenter" {
  default = "dal12"
}

variable "default_pool_size" {
  default = "2"
}

variable "private_vlan_id" {}

variable "public_vlan_id" {}

variable "name" {
  default = "cluster"
}
variable kube_version {
  default = "4.3_openshift"
}
