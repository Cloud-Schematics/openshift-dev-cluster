# Open Shift Development Environment
Provision a new team development OpenShift cluster preconfigured with the IBM Cloud Operator, CodeReady Workspaces, and CodeReady Pipelines.

This terraform template will:

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

# Post-installation configuration

After installation, additional configuration is needed to take advantage of the tools installed into your cluster.  

## IBM Cloud Operator
Once your cluster has been created and the IBM Cloud Operator has been installed, you must finish configuration of the IBM Cloud Operator before it can be used to create or bind services on IBM Cloud.  

You need an [IBM Cloud account](https://cloud.ibm.com/registration) and the 
[IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started).
You need also to have the [kubectl CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/)  
already configured to access your cluster. Before installing the operator, you need to login to 
your IBM cloud account with the IBM Cloud CLI:

```bash
ibmcloud login
```

and set a default target environment for your resources with the command:

```bash
ibmcloud target --cf -g default
```

This will use the IBM Cloud ResourceGroup `default`. To specify a different ResourceGroup, use the following command:
```bash
ibmcloud target -g <resource-group>
```

Notice that the `org` and `space` must be included, even if no Cloud Foundry services will be instantiated.

You can then configure the operator running the following script:

```
curl -sL https://raw.githubusercontent.com/IBM/cloud-operators/master/hack/config-operator.sh | bash 
```

The script above creates an IBM Cloud API Key and stores it in a Kubernetes secret that can be accessed by the operator, and it sets defaults such as the resource group and region used to provision IBM Cloud Services. You can always override the defaults in the Service custom resource. If you prefer to create the secret and the defaults manually, consult the [IBM Cloud Operator documentation](https://github.com/IBM/cloud-operators).

## CodeReady Workspaces/Eclipse Che
Once the developement cluster terraform template has completed execution, you will end up with an OpenShift cluster that already has the CodeReady Workspaces Operator installed, and has already created a CheCluster instance.   You will see a direct URL to the CodeReady Workspaces instance in the Terraform logs, or you can open the OpenShift Dashboard, navigate to the `codeready-workspaces` project, and then find the `codeready`  deployment to see the URL route associated with the CheCluster instance.

**⚠️ Warning:** The first time that you attempt to log into the CodeReady Workspaces instance you will first log in and grant access using your IBM Cloud account's oAuth integration, and then continue to create a CodeReady Workspaces account.  When you create your CodeReady Workspaces account, you **MUST** change the default user name that is provided by the oAuth integration.  The default user name will likely be in the format `IAM#user@email.com`.  This format is not compatible with the CodeReady Workspaces runtime.  The user name should be an alphanumeric text string without any special characters and _without_ the `IAM#` prefix.    

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

