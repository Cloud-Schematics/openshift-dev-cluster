# cluster
Simple template to deploy an IBM Cloud Kubernetes Openshift cluster


# Prerequisite 
1) Download [Terraform binary](https://www.terraform.io/downloads.html).  Unzip it and keep the binary in path ex- /usr/local/bin.
2) Download [IBM Cloud Provider Plugin](https://github.com/IBM-Bluemix/terraform-provider-ibm/releases). Unzip it and keep the binary in path in the same directory where you placed Terraform binary in previous step. You can also build the binary yourself. Please look into [documentation](https://github.com/IBM-Bluemix/terraform-provider-ibm/blob/master/README.md).

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
|machine_type| The type of the machine flavor|b2c.8x32| 
|hardware   |  The level of hardware isolation for your worker node|shared|
|datacenter|The datacenter to provision cluster |wdc07|
|default_pool_size| No of workers in default pool | 2 |
|private_vlan_id|The private vlan ID. Run ic ks vlans `datacenter` to retrieve vlans||
|public_vlan_id|The public vlan ID.Run ic ks vlans `datacenter` to retrieve vlans||
|kube_version|The desired Kubernetes openshift version of the created cluster.|4.3_openshift|
