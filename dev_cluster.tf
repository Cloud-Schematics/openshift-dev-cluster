resource "ibm_container_cluster" "create_cluster" {
  name              = var.cluster_name
  datacenter        = var.vlan_datacenter
  default_pool_size = var.cluster_worker_count
  machine_type      = var.cluster_machine_type
  hardware          = var.cluster_hardware
  resource_group_id = data.ibm_resource_group.resource_group.id
  kube_version      = var.cluster_version
  public_vlan_id    = var.public_vlan_id
  private_vlan_id   = var.private_vlan_id
}

resource "null_resource" "install_ibm_cloud_operator" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/install-operator.sh"

    environment={
      APIKEY         = "${var.ibmcloud_api_key}"
      KUBECONFIG     = "${data.ibm_container_cluster_config.config.config_file_path}"
      OPERATOR_NAME  = "ibmcloud-operator"
      OPERATOR_CHANNEL = "alpha"
      OPERATOR_SOURCE = "community-operators"
    }
  }

  depends_on = [
    ibm_container_cluster.create_cluster
  ]
}

resource "null_resource" "install_codeready_workspaces_operator" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/install-operator.sh"

    environment={
      APIKEY         = "${var.ibmcloud_api_key}"
      KUBECONFIG     = "${data.ibm_container_cluster_config.config.config_file_path}"
      OPERATOR_NAME  = "codeready-workspaces"
      OPERATOR_NAMESPACE= "codeready-workspaces"
    }
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/install-che-cluster.sh"

    environment={
      APIKEY         = "${var.ibmcloud_api_key}"
      KUBECONFIG     = "${data.ibm_container_cluster_config.config.config_file_path}"
      NAME           = "codeready-workspaces"
      NAMESPACE      = "codeready-workspaces"
    }
  }  

  depends_on = [
    ibm_container_cluster.create_cluster
  ]
}

resource "null_resource" "install_openshift_pipelines_rh_operator" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/install-operator.sh"

    environment={
      APIKEY         = "${var.ibmcloud_api_key}"
      KUBECONFIG     = "${data.ibm_container_cluster_config.config.config_file_path}"
      OPERATOR_NAME  = "openshift-pipelines-operator-rh"
      OPERATOR_CHANNEL = "ocp-4.4"
    }
  } 
  depends_on = [
    ibm_container_cluster.create_cluster
  ]
}