resource "null_resource" "install_openshift_pipelines_rh_operator" {
  provisioner "local-exec" {
    command = "${path.cwd}/scripts/install-operator.sh"

    environment={
      KUBECONFIG     =  var.cluster_config_path
      OPERATOR_NAME  = "openshift-pipelines-operator-rh"
      OPERATOR_CHANNEL = "ocp-4.4"
    }
  } 
}