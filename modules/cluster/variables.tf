

# Resource Group Variables
variable "resource_group_name" {
  type        = string
  description = "Existing resource group where the IKS cluster will be provisioned. Use `ibmcloud resource groups` or visit https://cloud.ibm.com/account/resource-groups to see a list of available resource groups."
}

# Cluster Variables
variable "private_vlan_id" {
  type        = string
  description = "Existing private VLAN id for cluster creation. Use `ibmcloud ks vlan ls --zone <zone>` or visit https://cloud.ibm.com/classic/network/vlans to see a list of available private vlans.  If you do not have any existing vlans, leave this field blank."
}

variable "public_vlan_id" {
  type        = string
  description = "Existing public VLAN number for cluster creation. Use `ibmcloud ks vlan ls --zone <zone>` or visit https://cloud.ibm.com/classic/network/vlans to see a list of available public vlans. If you do not have any existing vlans, leave this field blank."
}

variable "datacenter" {
  type        = string
  description = "Datacenter for VLANs defined in private_vlan_number and public_vlan_number. Use `ibmcloud ks zone ls --provider classic` to see a list of availabe datacenters.  The data center should be in within the cluster's region."
}

variable "machine_type" {
  type        = string
  description = "The machine type for the cluster worker nodes (b3c.4x16 is minimum for OpenShift). Use `ibmcloud ks flavors --zone <zone>` to see the flavors available."
  default     = "b3c.4x16"
}

variable "default_pool_size" {
  description = "The number of worker nodes for the cluster."
  default     = 3
}

variable "hardware" {
  type        = string
  description = "The level of hardware isolation for your worker node. Use 'dedicated' to have available physical resources dedicated to you only, or 'shared' to allow physical resources to be shared with other IBM customers."
  default     = "shared"
}

variable "name" {
  type        = string
  description = "The name of the cluster"
}

variable "kube_version" {
  type        = string
  description = "The OpenShift version to install. Use `ibmcloud ks versions --show-version OpenShift` to see a list of OpenShift versions."
  default     = "4.3_openshift"
}

variable "entitlement" {
  type        = string
  description = "If you purchased an IBM Cloud Cloud Pak that includes an entitlement to run worker nodes that are installed with OpenShift Container Platform, enter `cloud_pak` to create your cluster with that entitlement so that you are not charged twice for the OpenShift license. Note that this option can be set only when you create the cluster. After the cluster is created, the cost for the OpenShift license occurred and you cannot disable this charge."
  default     = ""
}