# OpenShift cluster on Classic infrastrucutre for development environment

Provision a new team development OpenShift cluster that is preconfigured with the IBM Cloud Operator, CodeReady Workspaces, and CodeReady Pipelines.

This Terraform template does the following actions:

1. Create an OpenShift cluster on [IBM Cloud](https://cloud.ibm.com).
2. Install the [IBM Cloud Operator](https://github.com/IBM/cloud-operators) into the cluster.
3. Install the [CodeReady Workspaces Operator](https://github.com/redhat-developer/codeready-workspaces-operator) into the cluster.
4. Create an instance of Eclipse Che (team editing environment) inside of the cluster.
5. Install the [CodeReady Pipelines Operator](https://github.com/openshift/tektoncd-pipeline) into the cluster.

# Prerequisites

- Create an [IBM Cloud account](https://cloud.ibm.com/registration).
- Install the [IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started).
- Install the [OpenShift CLI](https://cloud.ibm.com/docs/openshift?topic=openshift-openshift-cli).
- Download [Terraform binary](https://www.terraform.io/downloads.html). Extract the file and keep the binary in path `ex- /usr/local/bin`.
- Download [IBM Cloud Provider plug-in](https://github.com/IBM-Bluemix/terraform-provider-ibm/releases). Extract the file and keep the binary in path in the same directory where you placed Terraform binary in the previous step. You can also build the binary yourself. For more information, see the [Terraform provider documentation](https://github.com/IBM-Bluemix/terraform-provider-ibm/blob/master/README.md).
- Ensure that the [kubectl CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/)  
is configured to access your cluster.

# Run this project locally

To run this project locally, complete the following steps:

- Clone this project.
- You can override default values that are in your `variables.tf` file.
  - Alternatively, you can supply these values by using the command line or [environment variables](https://www.terraform.io/intro/getting-started/variables.html).


# Deploy on IBM Cloud using IBM Cloud Schematics

You can use IBM Cloud Schematics to deploy this Terraform template in the cloud without having a local terraform configuration.   Just use this link:

- [Deploy on IBM Cloud](https://cloud.ibm.com/schematics/workspaces/create?repository=https://github.com/Cloud-Schematics/openshift-dev-cluster&terraform_version=terraform_v0.12)
  
## Environment variables that use IBMid credentials

Export the following environment variables:

- `TF_VAR_ibmcloud_api_key` - your IBM Cloud API key

On OS X, enter the following command into your terminal, and replace the `<value>` characters with the actual values (be sure to remove the `<>`):

- `export TF_VAR_ibmcloud_api_key=<value>`

# Postinstallation configuration

After installation, more configuration is needed to take advantage of the tools installed into your cluster.  

## IBM Cloud Operator

After your cluster is created and the IBM Cloud Operator is installed, you must finish configuration of the IBM Cloud Operator before it can be used to create or bind services on IBM Cloud.

Before installing the operator, complete these steps:

1. Log in to your IBM cloud account by using the IBM Cloud CLI:

```bash
ibmcloud login
```

2. Set a default target environment for your resources with the following command:

```bash
ibmcloud target --cf -g default
```

3. To specify a different IBM Cloud ResourceGroup other than `default`, use the following command:

```bash
ibmcloud target -g <resource-group>
```

Note that the `org` and `space` must be included, even if you do not plan to instantiate any Cloud Foundry services.

4. Configure the operator by running the following script:

```
curl -sL https://raw.githubusercontent.com/IBM/cloud-operators/master/hack/config-operator.sh | bash 
```

The script creates an IBM Cloud API Key and stores it in a Kubernetes secret that can be accessed by the operator. The script also sets defaults, such as the resource group and region that are used to provision IBM Cloud services. You can always override the defaults in the Service custom resource. If you prefer to create the secret and the defaults manually, see the [IBM Cloud Operator documentation](https://github.com/IBM/cloud-operators).

## CodeReady Workspaces/Eclipse Che

After the development cluster Terraform template is finished running, you get an OpenShift cluster that already has the CodeReady Workspaces Operator installed, and has already created a CheCluster instance.

To see the URL for the CodeReady Workspaces instance, do either of the following steps:
- View the Terraform logs to locate the direct URL to the CodeReady Workspaces instance.
- Open the OpenShift Dashboard, navigate to the `codeready-workspaces` project, and then find the `codeready` deployment to see the URL route that is associated with the CheCluster instance.

**⚠️ Warning:** The first time that you attempt to log in to the CodeReady Workspaces instance, you first log in and grant access by using your IBM Cloud account's oAuth integration, and then continue to create a CodeReady Workspaces account. When you create your CodeReady Workspaces account, you **must** change the default username that is provided by the oAuth integration. The default username is likely in the format `IAM#user@email.com`. This format is not compatible with the CodeReady Workspaces runtime. The username should be an alphanumeric text string without any special characters and _without_ the `IAM#` prefix.

# Variables

|Variable Name|Description|Default Value|
|-------------|-----------|-------------|
| resource_group_name | Existing resource group where the IBM Kubernetes Service cluster is provisioned. Use `ibmcloud resource groups` or visit https://cloud.ibm.com/account/resource-groups to see a list of available resource groups. | | 
|private_vlan_id   |  Existing private VLAN ID for cluster creation. Use `ibmcloud ks vlan ls --zone <zone>` or visit https://cloud.ibm.com/classic/network/vlans to see a list of available private VLANs. If you do not have any existing VLANs, leave this field blank. |  |
| public_vlan_id   |  Existing public VLAN ID for cluster creation. Use `ibmcloud ks vlan ls --zone <zone>` or visit https://cloud.ibm.com/classic/network/vlans to see a list of available public VLANs. If you do not have any existing VLANs, leave this field blank. |  |
| vlan_datacenter   | Data center for VLANs that are defined in `private_vlan_number` and `public_vlan_number`. Use `ibmcloud ks zone ls --provider classic` to see a list of available data centers. The data center should be within the cluster's region.  |  |
|cluster_machine_type   |  Machine type for the cluster worker nodes (b3c.4x16 is minimum for OpenShift). Use `ibmcloud ks flavors --zone <zone>` to see the available flavors. | b3c.4x16 |
|cluster_worker_count   | Number of worker nodes for the cluster.  | 3 |
|cluster_hardware   | Level of hardware isolation for your worker node. Use `dedicated` to have available physical resources that are dedicated to you only, or use `shared` to allow physical resources to be shared with other IBM customers.  | shared |
|cluster_name   | Name of the cluster.  |  |
|cluster_version   | OpenShift version to install. Use `ibmcloud ks versions --show-version OpenShift` to see a list of OpenShift versions.  | 4.3_openshift |
|cluster_region   | IBM Cloud region for the cluster installation. Use `ibmcloud regions` to see a list of regions.  |  |
