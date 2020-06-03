# OpenShift Dev Cluster
Terraform template for creating a team development cluster.   This template will:

1. Create a new OpenShift cluster on [IBM Cloud](https://cloud.ibm.com)
2. Install the [IBM Cloud Operator](https://github.com/IBM/cloud-operators) into the cluster
3. Install the [CodeReady Workspaces Operator](https://github.com/redhat-developer/codeready-workspaces-operator) into the cluster
4. Create an instance of Eclipse Che (team editing environment) inside of the cluster
5. Install the [CodeReady Pipelines Operator](https://github.com/openshift/tektoncd-pipeline) into the cluster


# Prerequisite 
- Create an [IBM Cloud account](https://cloud.ibm.com/registration)
- Install the [IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started)
- Install the [OpenShift CLI](https://cloud.ibm.com/docs/openshift?topic=openshift-openshift-cli)
- Download [Terraform binary](https://www.terraform.io/downloads.html).  Unzip it and keep the binary in path ex- /usr/local/bin.
- Download [IBM Cloud Provider Plugin](https://github.com/IBM-Bluemix/terraform-provider-ibm/releases). Unzip it and keep the binary in path in the same directory where you placed Terraform binary in previous step. You can also build the binary yourself. Please look into [documentation](https://github.com/IBM-Bluemix/terraform-provider-ibm/blob/master/README.md).

# To run this project locally execute the following steps:

- Clone this project.
- You can override default values that are in your variables.tf file.
  - Alternatively these values can be supplied via the command line or environment variables, see https://www.terraform.io/intro/getting-started/variables.html.
  
  ## Environment Variables using IBMid credentials
You'll need to export the following environment variables:

- `TF_VAR_ibmcloud_api_key` - your IBM Cloud api key

On OS X this is achieved by entering the following into your terminal, replacing the `<value>` characters with the actual values (remove the `<>`):

- `export TF_VAR_ibmcloud_api_key=<value>`


# Variables

|Variable Name|Description|Default Value|
|-------------|-----------|-------------|
|resource_group_name| Existing resource group where the IKS cluster will be provisioned. Use `ibmcloud resource groups` or visit https://cloud.ibm.com/account/resource-groups to see a list of available resource groups. | | 
|private_vlan_id   |  Existing private VLAN id for cluster creation. Use `ibmcloud ks vlan ls --zone <zone>` or visit https://cloud.ibm.com/classic/network/vlans to see a list of available private vlans.  If you do not have any existing vlans, leave this field blank. |  |
|public_vlan_id   |  Existing private VLAN id for cluster creation. Use `ibmcloud ks vlan ls --zone <zone>` or visit https://cloud.ibm.com/classic/network/vlans to see a list of available private vlans.  If you do not have any existing vlans, leave this field blank. |  |
| vlan_datacenter   | Datacenter for VLANs defined in private_vlan_number and public_vlan_number. Use `ibmcloud ks zone ls --provider classic` to see a list of availabe datacenters.  The data center should be in within the cluster's region.  |  |
|cluster_machine_type   |  The machine type for the cluster worker nodes (b3c.4x16 is minimum for OpenShift). Use `ibmcloud ks flavors --zone <zone>` to see the flavors available. | b3c.4x16 |
|cluster_worker_count   | The number of worker nodes for the cluster.  | 3 |
|cluster_hardware   | The level of hardware isolation for your worker node. Use 'dedicated' to have available physical resources dedicated to you only, or 'shared' to allow physical resources to be shared with other IBM customers.  | shared |
|cluster_name   | The name of the cluster  |  |
|cluster_version   | The OpenShift version to install. Use `ibmcloud ks versions --show-version OpenShift` to see a list of OpenShift versions.  | 4.3_openshift |
|cluster_region   | The IBM Cloud region where the cluster will be/has been installed. Use `ibmcloud regions` to see a list of regions.  |  |

