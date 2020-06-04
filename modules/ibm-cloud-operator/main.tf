resource "null_resource" "install_ibm_cloud_operator" {
  provisioner "local-exec" {
    command = "${path.cwd}/scripts/install-operator.sh"

    environment={
      KUBECONFIG     = var.cluster_config_path
      OPERATOR_NAME  = "ibmcloud-operator"
      OPERATOR_CHANNEL = "alpha"
      OPERATOR_SOURCE = "community-operators"
    }
  }
}