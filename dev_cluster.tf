module "cluster" {
  source            = "./modules/cluster"
  name              = var.cluster_name
  datacenter        = var.vlan_datacenter
  default_pool_size = var.cluster_worker_count
  machine_type      = var.cluster_machine_type
  hardware          = var.cluster_hardware
  resource_group_name = var.resource_group_name
  kube_version      = var.cluster_version
  public_vlan_id    = var.public_vlan_id
  private_vlan_id   = var.private_vlan_id
}

module "ibm-cloud-operator" {
  source            = "./modules/ibm-cloud-operator"
  cluster_config_path = module.cluster.cluster_config_path
}

module "code-ready-workspace" {
  source            = "./modules/code-ready-workspace"
  cluster_config_path = module.cluster.cluster_config_path
}

module "openshift-pipelines-operator" {
  source            = "./modules/openshift-pipelines-operator"
  cluster_config_path = module.cluster.cluster_config_path
}