variable "ibmcloud_api_key" {
  type        = string
  default = ""
  description = "The IAM API Key for IBM Cloud access"
}

# Resource Group Variables
variable "resource_group_name" {
  type        = string
  description = "Existing resource group where the IKS cluster will be provisioned. Use `ibmcloud resource groups` or visit https://cloud.ibm.com/account/resource-groups to see a list of available resource groups."
}

# Cluster Variables
variable "private_vlan_id" {
  type        = string
  default     = ""
  description = "Existing private VLAN id for cluster creation. Use `ibmcloud ks vlan ls --zone <zone>` or visit https://cloud.ibm.com/classic/network/vlans to see a list of available private vlans.  If you do not have any existing vlans, leave this field blank."
}

variable "public_vlan_id" {
  type        = string
  default     = ""
  description = "Existing public VLAN number for cluster creation. Use `ibmcloud ks vlan ls --zone <zone>` or visit https://cloud.ibm.com/classic/network/vlans to see a list of available public vlans. If you do not have any existing vlans, leave this field blank."
}

variable "vlan_datacenter" {
  type        = string
  description = "Datacenter for VLANs defined in private_vlan_number and public_vlan_number. Use `ibmcloud ks zone ls --provider classic` to see a list of availabe datacenters.  The data center should be in within the cluster's region."
}

variable "cluster_machine_type" {
  type        = string
  description = "The machine type for the cluster worker nodes (b3c.4x16 is minimum for OpenShift). Use `ibmcloud ks flavors --zone <zone>` to see the flavors available."
  default     = "b3c.4x16"
}

variable "cluster_worker_count" {
  description = "The number of worker nodes for the cluster."
  default     = 3
}

variable "cluster_hardware" {
  type        = string
  description = "The level of hardware isolation for your worker node. Use 'dedicated' to have available physical resources dedicated to you only, or 'shared' to allow physical resources to be shared with other IBM customers."
  default     = "shared"
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "cluster_version" {
  type        = string
  description = "The OpenShift version to install. Use `ibmcloud ks versions --show-version OpenShift` to see a list of OpenShift versions."
  default     = "4.5.24_openshift"
}
