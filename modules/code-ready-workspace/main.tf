resource "null_resource" "install_codeready_workspaces_operator" {
  provisioner "local-exec" {
    command = "${path.cwd}/scripts/install-operator.sh"

    environment={
      KUBECONFIG     = var.cluster_config_path
      OPERATOR_NAME  = "openshift-workspaces"
      OPERATOR_NAMESPACE= "openshift-workspaces"
    }
  }

  provisioner "local-exec" {
    command = "${path.cwd}/scripts/install-che-cluster.sh"

    environment={
      KUBECONFIG     = var.cluster_config_path
      NAME           = "openshift-workspaces"
      NAMESPACE      = "openshift-workspaces"
    }
  }  
}